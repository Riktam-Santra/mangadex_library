///@nodoc
class Chapter {
  late String hash;
  late List<String> data;
  late List<String> dataSaver;
  Chapter(this.hash, this.data, this.dataSaver);
  Chapter.fromJson(Map<String, dynamic> json) {
    hash = json['hash'] ?? '';
    data = [];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add(element);
      });
    }
    dataSaver = [];
    if (json['dataSaver'] != null) {
      json['dataSaver'].forEach((element) {
        dataSaver.add(element);
      });
    }
  }
  Map<String, dynamic> toJson() => {
        'hash': hash,
        'data': data,
        'dataSaver': dataSaver,
      };
}
