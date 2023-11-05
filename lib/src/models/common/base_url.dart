///@nodoc
import 'package:json_annotation/json_annotation.dart';

import '../at-home/chapter.dart';
part 'base_url.g.dart';

///@nodoc
@JsonSerializable()
class BaseUrl {
  final String? result;
  final String? baseUrl;
  final Chapter? chapter;
  BaseUrl(this.result, this.baseUrl, this.chapter);
  factory BaseUrl.fromJson(Map<String, dynamic> json) =>
      _$BaseUrlFromJson(json);
  Map<String, dynamic> toJson() => _$BaseUrlToJson(this);
}
