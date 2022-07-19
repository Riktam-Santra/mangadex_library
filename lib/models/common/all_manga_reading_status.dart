import 'package:json_annotation/json_annotation.dart';

///@nodoc
part 'all_manga_reading_status.g.dart';

@JsonSerializable()
class AllMangaReadingStatus {
  final String result;
  final Map<String, dynamic> statuses;
  AllMangaReadingStatus({
    required this.result,
    required this.statuses,
  });
  factory AllMangaReadingStatus.fromJson(Map<String, dynamic> json) =>
      _$AllMangaReadingStatusFromJson(json);
  Map<String, dynamic> toJson() => _$AllMangaReadingStatusToJson(this);
}
