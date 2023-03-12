import 'package:json_annotation/json_annotation.dart';

import 'single_custom_list_response.dart';
part 'multiple_custom_lists_response.g.dart';

///@nodoc
@JsonSerializable()
class MultipleCustomListResponse {
  final String? result;
  final String? response;
  final List<Data>? data;
  MultipleCustomListResponse(this.result, this.response, this.data);
  factory MultipleCustomListResponse.fromJson(Map<String, dynamic> json) =>
      _$MultipleCustomListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MultipleCustomListResponseToJson(this);
}
