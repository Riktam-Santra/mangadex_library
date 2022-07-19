import 'package:json_annotation/json_annotation.dart';

import 'author_data.dart';
part 'author_search_result.g.dart';

@JsonSerializable()
class AuthorSearchResult {
  final String result;
  final String response;
  final List<Data> data;
  final int limit;
  final int offset;
  final int total;
  AuthorSearchResult({
    required this.limit,
    required this.offset,
    required this.total,
    required this.result,
    required this.response,
    required this.data,
  });
  factory AuthorSearchResult.fromJson(Map<String, dynamic> json) =>
      _$AuthorSearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorSearchResultToJson(this);
}
