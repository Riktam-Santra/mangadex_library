///@nodoc
import 'package:mangadex_library/models/common/relationships.dart';

class Cover {
  late List<Data> data;
  late int limit;
  late int offset;
  late int total;
  Cover(this.data, this.limit, this.offset, this.total);
  Cover.fromJson(Map<String, dynamic> json) {
    data = <Data>[];
    json['data']!.forEach((v) {
      data.add(Data.fromJson(v));
    });

    limit = json['limit'] ?? 0;
    offset = json['offset'] ?? 0;
    total = json['total'] ?? 0;
  }
  Map<String, dynamic> toJson() => {
        'data': data.map((e) => e.toJson()).toString(),
        'limit': limit,
        'offset': offset,
        'total': total,
      };
}

class Data {
  late String id;
  late String type;
  late List<Relationship> relationships;
  late Attributes attributes;
  Data(this.id, this.type, this.attributes, this.relationships);
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';
    relationships = <Relationship>[];
    json['relationships']!.forEach((v) {
      relationships.add(Relationship.fromJson(v));
    });
    attributes = Attributes.fromJson(json['attributes']!);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'relationships': relationships.map((e) => e.toJson()).toString(),
        'attributes': attributes.toJson(),
      };
}

class Attributes {
  late String volume;
  late String fileName;
  late String description;
  late int version;
  late String createdAt;
  late String updatedAt;
  Attributes(this.volume, this.fileName, this.description, this.version,
      this.createdAt, this.updatedAt);
  Attributes.fromJson(Map<String, dynamic> json) {
    volume = json['volume'] ?? 'null';
    fileName = json['fileName'] ?? 'null';
    description = json['description'] ?? 'null';
    version = json['version'] ?? 'null';
    createdAt = json['createdAt'] ?? 'null';
    updatedAt = json['updatedAt'] ?? 'null';
  }

  Map<String, dynamic> toJson() => {
        'volume': volume,
        'fileName': fileName,
        'description': description,
        'version': version,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
