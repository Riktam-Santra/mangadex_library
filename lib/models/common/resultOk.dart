class Result {
  late String result;

  Result({required this.result});

  Result.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }

  Map<String, dynamic> toJson() => {'result': result};
}
