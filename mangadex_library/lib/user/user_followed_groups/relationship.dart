import 'attributes.dart';

class Relationship {
	String? id;
	String? type;
	Attributes? attributes;

	Relationship({this.id, this.type, this.attributes});

	factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
				id: json['id'] as String?,
				type: json['type'] as String?,
				attributes: json['attributes'] == null
						? null
						: Attributes.fromJson(json['attributes'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'type': type,
				'attributes': attributes?.toJson(),
			};
}
