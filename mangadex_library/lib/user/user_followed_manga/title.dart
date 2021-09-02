class Title {
	String? en;
	String? fr;

	Title({this.en, this.fr});

	factory Title.fromJson(Map<String, dynamic> json) => Title(
				en: json['en'] as String?,
				fr: json['fr'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'en': en,
				'fr': fr,
			};
}
