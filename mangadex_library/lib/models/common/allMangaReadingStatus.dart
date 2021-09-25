class AllMangaReadingStatus {
  late String result;
  late Map<String, String> statuses;
  AllMangaReadingStatus(this.result, this.statuses);
  AllMangaReadingStatus.fromJson(Map<String, dynamic> json) {
    result = json['result']!;
    statuses = json['statuses']!;
  }
}