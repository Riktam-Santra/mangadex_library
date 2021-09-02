class Attributes {
	String? name;
	String? website;
	String? ircServer;
	String? ircChannel;
	String? discord;
	String? contactEmail;
	String? description;
	bool? locked;
	bool? official;
	int? version;
	String? createdAt;
	String? updatedAt;

	Attributes({
		this.name, 
		this.website, 
		this.ircServer, 
		this.ircChannel, 
		this.discord, 
		this.contactEmail, 
		this.description, 
		this.locked, 
		this.official, 
		this.version, 
		this.createdAt, 
		this.updatedAt, 
	});

	factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
				name: json['name'] as String?,
				website: json['website'] as String?,
				ircServer: json['ircServer'] as String?,
				ircChannel: json['ircChannel'] as String?,
				discord: json['discord'] as String?,
				contactEmail: json['contactEmail'] as String?,
				description: json['description'] as String?,
				locked: json['locked'] as bool?,
				official: json['official'] as bool?,
				version: json['version'] as int?,
				createdAt: json['createdAt'] as String?,
				updatedAt: json['updatedAt'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'name': name,
				'website': website,
				'ircServer': ircServer,
				'ircChannel': ircChannel,
				'discord': discord,
				'contactEmail': contactEmail,
				'description': description,
				'locked': locked,
				'official': official,
				'version': version,
				'createdAt': createdAt,
				'updatedAt': updatedAt,
			};
}
