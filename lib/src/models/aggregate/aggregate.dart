import 'package:json_annotation/json_annotation.dart';

part 'aggregate.g.dart';

///@nodoc
@JsonSerializable()
class Aggregate {
  final String? result;
  final Map<String, Volume>? volumes;
  Aggregate(this.result, this.volumes);
  factory Aggregate.fromJson(Map<String, dynamic> json) =>
      _$AggregateFromJson(json);
  Map<String, dynamic> toJson() => _$AggregateToJson(this);
}

///@nodoc
@JsonSerializable()
class Volume {
  final String? volume;
  final int? count;
  final Map<String, ChapterInfo>? chapters;
  Volume(this.volume, this.count, this.chapters);
  factory Volume.fromJson(Map<String, dynamic> json) => _$VolumeFromJson(json);
  Map<String, dynamic> toJson() => _$VolumeToJson(this);
}

///@nodoc
@JsonSerializable()
class ChapterInfo {
  final String? chapter;
  final String? id;
  final List<String>? others;
  final int? count;
  ChapterInfo(this.chapter, this.id, this.others, this.count);
  factory ChapterInfo.fromJson(Map<String, dynamic> json) =>
      _$ChapterInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterInfoToJson(this);
}
