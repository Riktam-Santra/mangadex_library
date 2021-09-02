import 'attributes.dart';
import 'relationship.dart';

class Data {
	String? id;
	String? type;
	Attributes? attributes;
	List<Relationship>? relationships;

	Data({this.id, this.type, this.attributes, this.relationships});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				id: json['id'] as String?,
				type: json['type'] as String?,
				attributes: json['attributes'] == null
						? null
						: Attributes.fromJson(json['attributes'] as Map<String, dynamic>),
				relationships: (json['relationships'] as List<dynamic>?)
						?.map((e) => Relationship.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'type': type,
				'attributes': attributes?.toJson(),
				'relationships': relationships?.map((e) => e.toJson()).toList(),
			};
}
