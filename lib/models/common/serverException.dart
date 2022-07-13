///@nodoc
class ServerException {
  late String result;
  late List<Error> errors;
  ServerException.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? 'error';
    errors = <Error>[];
    if (json['errors'] != null) {
      json['errors'].forEach((e) {
        errors.add(Error.fromJson(e));
      });
    }
  }
  Map<String, dynamic> toJson() => {
        'result': result,
        'errors': errors.map((e) => e.toJson()),
      };
}

class Error {
  late String id;
  late int status;
  late String title;
  late String detail;

  Error.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    status = json['status'] ?? 0;
    title = json['title'] ?? '';
    detail = json['detail'] ?? '';
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'title': title,
        'detail': detail,
      };
}
