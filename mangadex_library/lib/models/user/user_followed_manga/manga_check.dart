import 'package:mangadex_library/mangadexServerException.dart';

class MangaCheck {
  late String result;

  MangaCheck(this.result);

  MangaCheck.fromJson(Map<String, dynamic> json) {
    try {
      result = json['result'] ?? '';
    } on Exception {
      throw MangadexServerException(json);
    }
  }
}
