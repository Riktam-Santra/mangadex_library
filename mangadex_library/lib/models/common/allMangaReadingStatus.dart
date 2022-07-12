///@nodoc
class AllMangaReadingStatus {
  late String result;
  late Map<String, dynamic> statuses;
  AllMangaReadingStatus(this.result, this.statuses);
  AllMangaReadingStatus.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    if (json['statuses'].runtimeType != List) {
      statuses = json['statuses'] ?? {};
    } else {
      statuses = {};
    }
  }
}
