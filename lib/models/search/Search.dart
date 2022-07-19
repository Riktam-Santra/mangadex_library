///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/data.dart';
part 'search.g.dart';

@JsonSerializable()
class Search {
  final String result;
  final String response;
  final List<Data> data;
  final int limit;
  final int offset;
  final int total;
  Search({
    required this.data,
    required this.limit,
    required this.offset,
    required this.total,
    required this.result,
    required this.response,
  });
  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
  Map<String, dynamic> toJson() => _$SearchToJson(this);
}
