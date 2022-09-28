import 'scanlationsResult.dart';

class Scanlation {
  late String result;
  late String response;
  late Data data;
  late int limit;
  late int offset;
  late int total;
  Scanlation(this.result, this.response, this.data, this.limit, this.offset,
      this.total);
  Scanlation.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    response = json['response'] ?? '';
    data = Data.fromJson(json['data']);
    limit = json['limit'] ?? 0;
    offset = json['offset'] ?? 0;
    total = json['total'] ?? 0;
  }
}
