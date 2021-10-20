import 'package:mangadex_library/src/models/common/data.dart';

class SingleMangaData {
  late final String result;
  late final String response;
  late final Data data;
  SingleMangaData(this.result, this.response, this.data);
  SingleMangaData.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    response = json['response'];
    data = Data.fromJson(json['data']);
  }
}
