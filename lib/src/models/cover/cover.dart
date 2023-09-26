///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/src/models/common/relationships.dart';
part 'cover.g.dart';

///@nodoc
@JsonSerializable()
class Cover {
  final List<Data>? data;
  final int? limit;
  final int? offset;
  final int? total;
  Cover(this.data, this.limit, this.offset, this.total);
  factory Cover.fromJson(Map<String, dynamic> json) => _$CoverFromJson(json);

  Map<String, dynamic> toJson() => _$CoverToJson(this);
}

///@nodoc
@JsonSerializable()
class Data {
  final String? id;
  final String? type;
  final List<Relationship>? relationships;
  final Attributes? attributes;
  Data(this.id, this.type, this.attributes, this.relationships);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

///@nodoc
@JsonSerializable()
class Attributes {
  final String? volume;
  final String? fileName;
  final String? description;
  final int? version;
  final String? createdAt;
  final String? updatedAt;
  Attributes(this.volume, this.fileName, this.description, this.version,
      this.createdAt, this.updatedAt);
  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);

  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}
