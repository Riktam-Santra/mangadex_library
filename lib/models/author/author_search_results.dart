import 'author_info.dart';

class AuthorSearchResult {
  late String result;
  late String response;
  late List<Data> data;
  late int limit;
  late int offset;
  late int total;
  AuthorSearchResult(this.result, this.response, this.data);
  AuthorSearchResult.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    response = json['response'] ?? '';
    data = [];
    if (json['data'] != null) {
      json['data'].forEach((e) {
        data.add(Data.fromJson(e));
      });
    }
    limit = json['limit'] ?? 0;
    offset = json['offset'] ?? 0;
    total = json['total'] ?? 0;
  }
  Map<String, dynamic> toJson() => {
        'result': result,
        'response': response,
        'data': data.map((e) => e.toJson()).toString(),
        'limit': limit.toString(),
        'offset': offset.toString(),
        'total': total.toString(),
      };
}
