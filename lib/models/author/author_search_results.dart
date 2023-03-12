import 'package:json_annotation/json_annotation.dart';

import 'author_info.dart';
part 'author_search_results.g.dart';

///@nodoc
@JsonSerializable()
class AuthorSearchResults {
  final String? result;
  final String? response;
  final List<Data>? data;
  final int? limit;
  final int? offset;
  final int? total;
  AuthorSearchResults(this.result, this.response, this.data, this.limit,
      this.offset, this.total);
  factory AuthorSearchResults.fromJson(Map<String, dynamic> json) =>
      _$AuthorSearchResultsFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorSearchResultsToJson(this);
}
