import 'package:json_annotation/json_annotation.dart';
part 'alt_titles.g.dart';

///@nodoc
@JsonSerializable()
class AltTitles {
  final String? en;
  final String? fr;
  AltTitles(this.en, this.fr);
  factory AltTitles.fromJson(Map<String, dynamic> json) =>
      _$AltTitlesFromJson(json);
  Map<String, dynamic> toJson() => _$AltTitlesToJson(this);
}
