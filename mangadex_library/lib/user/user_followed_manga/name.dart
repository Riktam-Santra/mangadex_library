class Name {
	String? en;
	String? fr;

	Name({this.en, this.fr});

	factory Name.fromJson(Map<String, dynamic> json) => Name(
				en: json['en'] as String?,
				fr: json['fr'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'en': en,
				'fr': fr,
			};
}
