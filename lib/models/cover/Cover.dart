///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/relationships.dart';
part 'cover.g.dart';

@JsonSerializable()
class Cover {
  final List<Data> data;
  final int limit;
  final int offset;
  final int total;
  Cover({
    required this.data,
    required this.limit,
    required this.offset,
    required this.total,
  });
  factory Cover.fromJson(Map<String, dynamic> json) => _$CoverFromJson(json);
  Map<String, dynamic> toJson() => _$CoverToJson(this);
}

@JsonSerializable()
class Data {
  final String id;
  final String type;
  final List<Relationship> relationships;
  final Attributes attributes;
  Data({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Attributes {
  final String volume;
  final String fileName;
  final String description;
  final int version;
  final String createdAt;
  final String updatedAt;
  Attributes({
    required this.volume,
    required this.fileName,
    required this.description,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);

  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}
