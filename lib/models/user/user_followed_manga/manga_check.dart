///@nodoc
class MangaCheck {
  late String result;

  MangaCheck(this.result);

  MangaCheck.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
  }
  Map<String, dynamic> toJson() => {
    'result': result,
  };
}
