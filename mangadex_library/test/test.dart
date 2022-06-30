import 'package:mangadex_library/mangadex_library.dart';
import 'package:mangadex_library/models/common/order_enums.dart';
import 'package:test/test.dart';

void main() {
  group('Search Function', () {
    var query = 'oregairu';
    test('Search function check with only query', () async {
      print('searching for manga with query value: $query');
      var data = await search(query: query);
      expect('ok', data.result);
    });
    test('Search function check with query and order', () async {
      print('searching for manga with query value: $query');
      var data = await search(
        query: query,
        orders: {SearchOrders.createdAt, OrderDirections.ascending}
            as Map<SearchOrders, OrderDirections>,
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
    var mangaId = '0296dc0b-7635-4154-927a-33c2244c4503';
    test('Fetch manga chapter data', () async {
      print('fetching manga details for manga with UUID: $mangaId');
      var data = await getChapters(mangaId);
      expect('ok', data.data[0].type);
    });
  });
}
