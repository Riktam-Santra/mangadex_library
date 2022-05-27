import 'package:mangadex_library/mangadex_library.dart';
import 'package:test/test.dart';

void main() {
  group('ScanlationResult', () {
    test('json parsing test', () async {
      var data =
          await getScanlationGroupById('6e4f5bba-cb6a-45a2-b744-f9d23367d6e4');
      expect(data.result, equals('ok'));
    });
  });
}
