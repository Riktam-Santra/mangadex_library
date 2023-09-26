import 'package:json_annotation/json_annotation.dart';
part 'server_exception.g.dart';

///@nodoc
@JsonSerializable()
class ServerException {
  final String? result;
  final List<Error>? errors;
  ServerException(this.result, this.errors);
  factory ServerException.fromJson(Map<String, dynamic> json) =>
      _$ServerExceptionFromJson(json);
  Map<String, dynamic> toJson() => _$ServerExceptionToJson(this);
}

///@nodoc
@JsonSerializable()
class Error {
  final String? id;
  final int? status;
  final String? title;
  final String? detail;
  Error(this.id, this.status, this.title, this.detail);
  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
