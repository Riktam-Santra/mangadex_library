import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/mangadexServerException.dart';
import 'package:mangadex_library/models/common/data.dart';

part 'single_manga_data.g.dart';

///@nodoc
@JsonSerializable()
class SingleMangaData {
  final String? result;
  final String? response;
  final Data? data;
  SingleMangaData(this.result, this.response, this.data);
  factory SingleMangaData.fromJson(Map<String, dynamic> json) =>
      _$SingleMangaDataFromJson(json);

  Map<String, dynamic> toJson() => _$SingleMangaDataToJson(this);
}
