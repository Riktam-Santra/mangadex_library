///@nodoc
import 'package:mangadex_library/models/common/data.dart';

class Search {
  late final String result;
  late final String response;
  late final List<Data> data;
  late final int limit;
  late final int offset;
  late final int total;
  Search(this.data, this.limit, this.offset, this.total);
  Search.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';

    response = json['response'] ?? '';
    data = <Data>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
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
