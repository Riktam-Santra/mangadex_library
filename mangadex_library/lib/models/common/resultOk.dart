class ResultOk {
  late String result;

  ResultOk({required this.result});

  ResultOk.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['result'] = result;
    return data;
  }
}
