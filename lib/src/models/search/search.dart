import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/src/models/common/search_data.dart';

part 'search.g.dart';

///@nodoc
@JsonSerializable()
class Search {
  final String? result;
  final String? response;
  final List<SearchData>? data;
  final int? limit;
  final int? offset;
  final int? total;
  Search(this.data, this.limit, this.offset, this.total, this.result,
      this.response);
  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
  Map<String, dynamic> toJson() => _$SearchToJson(this);
}
