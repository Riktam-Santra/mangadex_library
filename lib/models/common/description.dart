import 'package:json_annotation/json_annotation.dart';
part 'description.g.dart';

///@nodoc
@JsonSerializable()
class Description {
  final String? en;
  final String? fr;
  Description(this.en, this.fr);
  factory Description.fromJson(Map<String, dynamic> json) =>
      _$DescriptionFromJson(json);
  Map<String, dynamic> toJson() => _$DescriptionToJson(this);
}
