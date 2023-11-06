///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/src/models/common/attributes.dart';
import 'package:mangadex_library/src/models/common/relationships.dart';
part 'search_data.g.dart';

///@nodoc
@JsonSerializable()
class SearchData {
  final String? id;
  final String? type;
  final Attributes? attributes;
  final List<Relationship>? relationships;
  SearchData(this.id, this.type, this.attributes, this.relationships);
  factory SearchData.fromJson(Map<String, dynamic> json) =>
      _$SearchDataFromJson(json);
  Map<String, dynamic> toJson() => _$SearchDataToJson(this);
}
