// ignore_for_file: omit_local_variable_types

import 'dart:convert';

import 'package:http/http.dart';
import 'package:mangadex_library/mangadex_library.dart';
import 'package:mangadex_library/models/aggregate/aggregate.dart';
import 'package:mangadex_library/models/common/order_enums.dart';
import 'package:mangadex_library/models/search/search.dart';
import 'package:mangadex_library/utils.dart';
import 'package:test/test.dart';

void main() {
  test('Retrieve urls', () async {
    Search s = await search(includes: [
      'cover_art'
    ], orders: {
      SearchOrders.followedCount: OrderDirections.descending,
    });

    Map<String, String> map = Utils.getCoverArtUrlMap(s);

    print(Utils.constructCoverPageUrl(map));

    expect(true, map.isNotEmpty);
  });
  test('Get Custom List', () async {
    var data =
        await getSingleCustomList('44224004-1fad-425e-b416-45b46b74d3d1');
    expect('ok', data.result!);
  });
  group('Search Function', () {
    var query = 'oregairu';
    test('Search function check with only query', () async {
      print('searching for manga with query value: $query');
      Search data = await search(query: query);

      expect('ok', data.result);
    });
    test('Search function check with query and order', () async {
      print('searching for manga with query value: $query');
      var data = await search(
        query: query,
        orders: {SearchOrders.createdAt: OrderDirections.ascending},
      );
      expect('ok', data.result);
    });
  });
  group('Manga', () {
    var mangaId = '0296dc0b-7635-4154-927a-33c2244c4503';
    test('Fetch manga details', () async {
      print('fetching manga details for manga with UUID: $mangaId');
      var data = await getMangaDataByMangaId(mangaId);
      expect('ok', data.result);
    });
  });
  group('Chapters', () {
    var pageUrl = '';
    var mangaId = '0296dc0b-7635-4154-927a-33c2244c4503';
    var chapterId = '';
    test('Fetch manga chapter data', () async {
      print('fetching manga details for manga with UUID: $mangaId');
      var data = await getChapters(mangaId);
      chapterId = data.data![0].id!;
      expect('ok', data.result);
    });
    test('Get chapter by Id', () async {
      print(
          'fetching chapter with UUID $chapterId for manga with UUID $mangaId');
      var data = await getChapterDataByChapterId(chapterId);

      pageUrl = constructPageUrl(data.baseUrl!, true, data.chapter!.hash!,
          data.chapter!.dataSaver!.first);
      expect('ok', data.result);
    });
    test('Page fetch check', () async {
      var data = await get(Uri.parse(pageUrl));
      expect(200, data.statusCode);
    });
  });
  test('Aggregate', () async {
    var data =
        await getMangaAggregateResponse('99620a4f-2c05-41f7-99b0-9467041bef3b');
    // print(data.body);
    Aggregate.fromJson(jsonDecode(data.body));
  });
}
