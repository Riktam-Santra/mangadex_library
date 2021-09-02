import 'alt_title.dart';
import 'description.dart';
import 'links.dart';
import 'tag.dart';
import 'title.dart';

class Attributes {
	Title? title;
	List<AltTitle>? altTitles;
	Description? description;
	bool? isLocked;
	Links? links;
	String? originalLanguage;
	String? lastVolume;
	String? lastChapter;
	String? publicationDemographic;
	String? status;
	int? year;
	String? contentRating;
	List<Tag>? tags;
	int? version;
	String? createdAt;
	String? updatedAt;

	Attributes({
		this.title, 
		this.altTitles, 
		this.description, 
		this.isLocked, 
		this.links, 
		this.originalLanguage, 
		this.lastVolume, 
		this.lastChapter, 
		this.publicationDemographic, 
		this.status, 
		this.year, 
		this.contentRating, 
		this.tags, 
		this.version, 
		this.createdAt, 
		this.updatedAt, 
	});

	factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
				title: json['title'] == null
						? null
						: Title.fromJson(json['title'] as Map<String, dynamic>),
				altTitles: (json['altTitles'] as List<dynamic>?)
						?.map((e) => AltTitle.fromJson(e as Map<String, dynamic>))
						.toList(),
				description: json['description'] == null
						? null
						: Description.fromJson(json['description'] as Map<String, dynamic>),
				isLocked: json['isLocked'] as bool?,
				links: json['links'] == null
						? null
						: Links.fromJson(json['links'] as Map<String, dynamic>),
				originalLanguage: json['originalLanguage'] as String?,
				lastVolume: json['lastVolume'] as String?,
				lastChapter: json['lastChapter'] as String?,
				publicationDemographic: json['publicationDemographic'] as String?,
				status: json['status'] as String?,
				year: json['year'] as int?,
				contentRating: json['contentRating'] as String?,
				tags: (json['tags'] as List<dynamic>?)
						?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
						.toList(),
				version: json['version'] as int?,
				createdAt: json['createdAt'] as String?,
				updatedAt: json['updatedAt'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'title': title?.toJson(),
				'altTitles': altTitles?.map((e) => e.toJson()).toList(),
				'description': description?.toJson(),
				'isLocked': isLocked,
				'links': links?.toJson(),
				'originalLanguage': originalLanguage,
				'lastVolume': lastVolume,
				'lastChapter': lastChapter,
				'publicationDemographic': publicationDemographic,
				'status': status,
				'year': year,
				'contentRating': contentRating,
				'tags': tags?.map((e) => e.toJson()).toList(),
				'version': version,
				'createdAt': createdAt,
				'updatedAt': updatedAt,
			};
}
