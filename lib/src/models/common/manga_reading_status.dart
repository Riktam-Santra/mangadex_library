import 'package:json_annotation/json_annotation.dart';
part 'manga_reading_status.g.dart';

///@nodoc
@JsonSerializable()
class MangaReadingStatus {
  final String? result;
  final String? status;
  MangaReadingStatus(this.result, this.status);
  factory MangaReadingStatus.fromJson(Map<String, dynamic> json) =>
      _$MangaReadingStatusFromJson(json);
  Map<String, dynamic> toJson() => _$MangaReadingStatusToJson(this);
}
