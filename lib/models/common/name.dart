import 'package:json_annotation/json_annotation.dart';

part 'name.g.dart';

///@nodoc
@JsonSerializable()
class Name {
  final String? en;
  final String? fr;
  Name(this.en, this.fr);
  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);
  Map<String, dynamic> toJson() => _$NameToJson(this);
}
