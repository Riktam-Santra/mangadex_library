import 'package:json_annotation/json_annotation.dart';

part 'all_manga_reading_status.g.dart';

///@nodoc
@JsonSerializable()
class AllMangaReadingStatus {
  final String? result;
  final Map<String, dynamic>? statuses;
  AllMangaReadingStatus(this.result, this.statuses);
  factory AllMangaReadingStatus.fromJson(Map<String, dynamic> json) =>
      _$AllMangaReadingStatusFromJson(json);
  Map<String, dynamic> toJson() => _$AllMangaReadingStatusToJson(this);
}
