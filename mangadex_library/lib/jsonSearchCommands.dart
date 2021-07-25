import 'package:mangadex_library/chapter/Chapter.dart';
import 'mangadex_library.dart';

class jsonSearch {
  List<String> getChapterFilenames(
      String chapterID, Chapter chapters, bool isDataSaverMode) {
    for (var i = 0; i < chapters.result.length; i++) {
      if (chapters.result[i].data.id == chapterID) {
        if (isDataSaverMode == false) {
          return chapters.result[i].data.attributes.chapterData;
        } else if (isDataSaverMode == true) {
          return chapters.result[i].data.attributes.chapterDataSaver;
        }
      } else {
        print('Chapter by ID $chapterID not found');
        return <String>[];
      }
    }
    return <String>[];
  }
}
