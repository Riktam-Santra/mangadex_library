import 'package:json_annotation/json_annotation.dart';

///@nodoc
part 'chapter.g.dart';

@JsonSerializable()
class Chapter {
  final String hash;
  final List<String> data;
  final List<String> dataSaver;
  Chapter({
    required this.hash,
    required this.data,
    required this.dataSaver,
  });
  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}
