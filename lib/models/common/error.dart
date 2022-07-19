import 'package:json_annotation/json_annotation.dart';
part 'error.g.dart';

///@nodoc

@JsonSerializable()
class Error {
  final String id;
  final int status;
  final String title;
  final String detail;

  Error(
      {required this.id,
      required this.status,
      required this.title,
      required this.detail});

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
