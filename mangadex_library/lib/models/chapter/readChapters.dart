import 'package:mangadex_library/mangadexServerException.dart';

class ReadChapters {
  late String result;
  late List<String> data;

  ReadChapters({required this.result, required this.data});

  ReadChapters.fromJson(Map<String, dynamic> json) {
    try {
      result = json['result'] ?? '';
      data = (json['data'] ?? []).cast<String>();
    } on Exception {
      throw MangadexServerException(json);
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['result'] = result;
    data['data'] = data;
    return data;
  }
}
