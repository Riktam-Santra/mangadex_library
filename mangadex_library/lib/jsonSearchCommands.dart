import 'package:mangadex_library/chapter/ChapterData.dart';
import 'mangadex_library.dart';

class JsonSearch {
  List<String> getChapterFilenames(
      String chapterID, ChapterData chapters, bool isDataSaverMode) {
    for (var i = 0; i < chapters.result.length; i++) {
      if (chapters.result[i].data.id == chapterID) {
        if (isDataSaverMode == false) {
          return chapters.result[i].data.attributes.chapterData;
        } else if (isDataSaverMode == true) {
          return chapters.result[i].data.attributes.chapterDataSaver;
        }
      } else {
        print('Chapter by ID $chapterID not found');
      }
    }
    return <String>[];
  }

  Result getChapterDataByChapterId(String chapterId, ChapterData chapters) {
    for (var i = 0; i < chapters.result.length; i++) {
      if (chapters.result[i].data.id == chapterId) {
        return chapters.result[i];
      } else {
        print('Chapter data using ID $chapterId not found');
      }
    }
    return chapters.result[0];
  }
}
