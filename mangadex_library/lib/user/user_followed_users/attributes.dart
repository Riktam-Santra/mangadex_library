class Attributes {
	String? username;
	List<String>? roles;
	int? version;

	Attributes({this.username, this.roles, this.version});

	factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
				username: json['username'] as String?,
				roles: json['roles'] as List<String>?,
				version: json['version'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'username': username,
				'roles': roles,
				'version': version,
			};
}
