import 'package:json_annotation/json_annotation.dart';

part 'read_chapters.g.dart';

///@nodoc
@JsonSerializable()
class ReadChapters {
  final String result;
  final List<String> data;

  ReadChapters(this.result, this.data);

  factory ReadChapters.fromJson(Map<String, dynamic> json) =>
      _$ReadChaptersFromJson(json);
  Map<String, dynamic> toJson() => _$ReadChaptersToJson(this);
}
