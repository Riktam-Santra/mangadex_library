///@nodoc
class Relationship {
  late final String id;
  late final String type;
  Relationship(this.id, this.type);
  Relationship.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
      };
}
