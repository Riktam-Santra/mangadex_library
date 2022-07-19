import 'package:json_annotation/json_annotation.dart';
import 'author_attributes.dart';

part 'author_data.g.dart';

@JsonSerializable()
class Data {
  final String id;
  final String type;
  final Attributes attributes;
  Data({
    required this.id,
    required this.type,
    required this.attributes,
  });
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
