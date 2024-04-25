// ignore_for_file: omit_local_variable_types

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:mangadex_library/mangadex_client.dart';
import 'package:mangadex_library/src/client_types/personal_client.dart';
import 'package:mangadex_library/src/util/utils.dart';
import 'package:test/test.dart';

void main() async {
  const username = 'YOUR_USERNAME';
  const password = 'YOUR_PASSWORD';
  const clientId = 'YOUR_CLIENT_ID';
  const clientSecret = 'YOUR_CLIENT_SECRET';
  MangadexPersonalClient client = MangadexPersonalClient(
    clientId: clientId,
    clientSecret: clientSecret,
    refreshDuration: Duration(seconds: 5),
    onRefresh: () {
      log('Token refreshed successfully');
    },
  );

  await Future.delayed(Duration(seconds: 10));

  test('Login', () => client.login(username, password));
  test('Retrieve urls', () async {
    Search s = await client.search(includes: [
      'cover_art'
    ], orders: {
      SearchOrders.followedCount: OrderDirections.descending,
    });

    Map<String, String> map = Utils.getCoverArtUrlMap(s);

    print(Utils.constructCoverPageUrl(map));

    expect(true, map.isNotEmpty);
  });
  test('Get Custom List', () async {
    var data = await client
        .getSingleCustomList('44224004-1fad-425e-b416-45b46b74d3d1');
    expect('ok', data.result!);
  });
  group('Search Function', () {
    var query = 'oregairu';
    test('Search function check with only query', () async {
      print('searching for manga with query value: $query');
      Search data = await client.search(query: query);

      expect('ok', data.result);
    });
    test('Search function check with query and order', () async {
      print('searching for manga with query value: $query');
      var data = await client.search(
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
      var data = await client.getMangaDataByMangaId(mangaId);
      expect('ok', data.result);
    });
  });
  group('Chapters', () {
    var pageUrl = '';
    var mangaId = '0296dc0b-7635-4154-927a-33c2244c4503';
    var chapterId = '';
    test('Fetch manga chapter data', () async {
      print('fetching manga details for manga with UUID: $mangaId');
      var data = await client.getChapters(mangaId);
      chapterId = data.data![0].id!;
      expect('ok', data.result);
    });
    test('Get chapter by Id', () async {
      print(
          'fetching chapter with UUID $chapterId for manga with UUID $mangaId');
      var data = await client.getBaseUrl(chapterId);

      pageUrl = client.constructPageUrl(data.baseUrl!, true,
          data.chapter!.hash!, data.chapter!.dataSaver!.first);
      expect('ok', data.result);
    });
    test('Page fetch check', () async {
      var data = await get(Uri.parse(pageUrl));
      expect(200, data.statusCode);
    });
  });
  test('Aggregate', () async {
    var data = await client
        .getMangaAggregateResponse('99620a4f-2c05-41f7-99b0-9467041bef3b');
    var parsedData = Aggregate.fromJson(jsonDecode(data.body));
    expect('ok', parsedData.result);
  });

  test('Get manga feed', () async {
    var data = await client.getMangaFeed('23b51846-bec4-41e4-a9a2-a034064d01eb',
        translatedLanguage: [LanguageCodes.en]);

    for (final MangaFeedData manga in data.data ?? []) {
      print(manga.attributes?.translatedLanguage ?? '');
    }
    expect('ok', data.result);
  });
}
