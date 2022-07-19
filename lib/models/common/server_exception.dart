import 'package:json_annotation/json_annotation.dart';

import 'error.dart';
part 'server_exception.g.dart';

///@nodoc
@JsonSerializable()
class ServerException {
  final String result;
  final List<Error> errors;
  ServerException({
    required this.result,
    required this.errors,
  });
  factory ServerException.fromJson(Map<String, dynamic> json) =>
      _$ServerExceptionFromJson(json);
  Map<String, dynamic> toJson() => _$ServerExceptionToJson(this);
}
