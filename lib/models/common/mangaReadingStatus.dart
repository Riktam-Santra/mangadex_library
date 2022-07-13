///@nodoc
class MangaReadingStatus {
  late String result;
  late String status;
  MangaReadingStatus(this.result, this.status);
  MangaReadingStatus.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    status = json['status'] ?? '';
  }

  Map<String, dynamic> toJson() => {
        'result': result,
        'status': status,
      };
}
