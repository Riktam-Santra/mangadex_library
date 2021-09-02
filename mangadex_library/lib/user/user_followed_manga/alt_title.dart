class AltTitle {
	String? en;
	String? fr;

	AltTitle({this.en, this.fr});

	factory AltTitle.fromJson(Map<String, dynamic> json) => AltTitle(
				en: json['en'] as String?,
				fr: json['fr'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'en': en,
				'fr': fr,
			};
}
