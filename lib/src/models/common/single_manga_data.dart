import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/src/models/common/search_data.dart';

part 'single_manga_data.g.dart';

///@nodoc
@JsonSerializable()
class SingleMangaData {
  final String? result;
  final String? response;
  final SearchData? data;
  SingleMangaData(this.result, this.response, this.data);
  factory SingleMangaData.fromJson(Map<String, dynamic> json) =>
      _$SingleMangaDataFromJson(json);

  Map<String, dynamic> toJson() => _$SingleMangaDataToJson(this);
}
