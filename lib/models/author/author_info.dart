import 'package:json_annotation/json_annotation.dart';
import '../common/relationships.dart';
import 'author_data.dart';
part 'author_info.g.dart';

///@nodoc
@JsonSerializable()
class AuthorInfo {
  final String result;
  final String response;
  final Data data;
  final List<Relationship> relationships;
  AuthorInfo(
      {required this.result,
      required this.response,
      required this.data,
      required this.relationships});
  factory AuthorInfo.fromJson(Map<String, dynamic> json) =>
      _$AuthorInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorInfoToJson(this);
}
