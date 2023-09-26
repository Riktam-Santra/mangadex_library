import 'package:json_annotation/json_annotation.dart';
part 'chapter.g.dart';

///@nodoc
@JsonSerializable()
class Chapter {
  final String? hash;
  final List<String>? data;
  final List<String>? dataSaver;
  Chapter(this.hash, this.data, this.dataSaver);
  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}
