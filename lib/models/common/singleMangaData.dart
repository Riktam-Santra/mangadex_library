import 'package:mangadex_library/mangadexServerException.dart';

///@nodoc
import 'package:mangadex_library/models/common/data.dart';

class SingleMangaData {
  late final String result;
  late final String response;
  late final Data data;
  SingleMangaData(this.result, this.response, this.data);
  SingleMangaData.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    if (result == 'ok') {
      response = json['response'];
      data = Data.fromJson(json['data']);
    } else {
      throw MangadexServerException(json);
    }
  }
  Map<String, dynamic> toJson() => {
        'result': result,
        'response': response,
        'data': data.toJson(),
      };
}
