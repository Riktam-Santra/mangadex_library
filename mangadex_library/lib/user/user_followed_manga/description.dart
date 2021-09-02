class Description {
	String? en;
	String? fr;

	Description({this.en, this.fr});

	factory Description.fromJson(Map<String, dynamic> json) => Description(
				en: json['en'] as String?,
				fr: json['fr'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'en': en,
				'fr': fr,
			};
}
