///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/src/models/common/relationships.dart';

part 'cover.g.dart';

///@nodoc
@JsonSerializable()
class Cover {
  final List<CoverData>? data;
  final int? limit;
  final int? offset;
  final int? total;
  Cover(this.data, this.limit, this.offset, this.total);
  factory Cover.fromJson(Map<String, dynamic> json) => _$CoverFromJson(json);

  Map<String, dynamic> toJson() => _$CoverToJson(this);
}

///@nodoc
@JsonSerializable()
class CoverData {
  final String? id;
  final String? type;
  final List<Relationship>? relationships;
  final CoverAttributes? attributes;
  CoverData(this.id, this.type, this.attributes, this.relationships);
  factory CoverData.fromJson(Map<String, dynamic> json) =>
      _$CoverDataFromJson(json);

  Map<String, dynamic> toJson() => _$CoverDataToJson(this);
}

///@nodoc
@JsonSerializable()
class CoverAttributes {
  final String? volume;
  final String? fileName;
  final String? description;
  final int? version;
  final String? createdAt;
  final String? updatedAt;
  CoverAttributes(this.volume, this.fileName, this.description, this.version,
      this.createdAt, this.updatedAt);
  factory CoverAttributes.fromJson(Map<String, dynamic> json) =>
      _$CoverAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$CoverAttributesToJson(this);
}
