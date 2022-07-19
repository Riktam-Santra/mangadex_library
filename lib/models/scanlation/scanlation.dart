import 'package:json_annotation/json_annotation.dart';

import 'scanlations_result.dart';
part 'scanlation.g.dart';

@JsonSerializable()
class Scanlation {
  final String result;
  final String response;
  final Data data;
  final int limit;
  final int offset;
  final int total;
  Scanlation({
    required this.result,
    required this.response,
    required this.data,
    required this.limit,
    required this.offset,
    required this.total,
  });
  factory Scanlation.fromJson(Map<String, dynamic> json) =>
      _$ScanlationFromJson(json);
  Map<String, dynamic> toJson() => _$ScanlationToJson(this);
}
