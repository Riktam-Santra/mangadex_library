import 'package:json_annotation/json_annotation.dart';

///@nodoc
part 'description.g.dart';

@JsonSerializable()
class Description {
  final String? en;
  final String? fr;
  Description({
    required this.en,
    required this.fr,
  });
  factory Description.fromJson(Map<String, dynamic> json) =>
      _$DescriptionFromJson(json);
  Map<String, dynamic> toJson() => _$DescriptionToJson(this);
}
