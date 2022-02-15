class Chapter {
  late String hash;
  late List<String> data;
  late List<String> dataSaver;
  Chapter(this.hash, this.data, this.dataSaver);
  Chapter.fromJson(Map<String, dynamic> json) {
    hash = json['hash'] ?? '';
    data = [];
    json['data'].forEach((element) {
      data.add(element);
    });
    dataSaver = [];
    json['dataSaver'].forEach((element) {
      dataSaver.add(element);
    });
  }
}
