import 'package:json_annotation/json_annotation.dart';
part 'title.g.dart';

///@nodoc
@JsonSerializable()
class Title {
  final String? en;
  final String? fr;
  Title(this.en, this.fr);
  factory Title.fromJson(Map<String, dynamic> json) => _$TitleFromJson(json);
  Map<String, dynamic> toJson() => _$TitleToJson(this);
}
