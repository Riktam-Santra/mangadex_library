import 'package:json_annotation/json_annotation.dart';

part 'result_ok.g.dart';

@JsonSerializable()
class Result {
  final String result;

  Result({required this.result});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
