///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/attributes.dart';
import 'package:mangadex_library/models/common/relationships.dart';
part 'data.g.dart';

///@nodoc
@JsonSerializable()
class Data {
  final String? id;
  final String? type;
  final Attributes? attributes;
  final List<Relationship>? relationships;
  Data(this.id, this.type, this.attributes, this.relationships);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
