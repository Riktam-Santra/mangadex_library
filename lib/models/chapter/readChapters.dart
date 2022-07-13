///@nodoc
class ReadChapters {
  late String result;
  late List<String> data;

  ReadChapters({required this.result, required this.data});

  ReadChapters.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    data = (json['data'] ?? []).cast<String>();
  }

  Map<String, dynamic> toJson() => {
        'result': result,
        'data': data,
      };
}
