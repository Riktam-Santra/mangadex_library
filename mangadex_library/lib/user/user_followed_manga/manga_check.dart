class MangaCheck {
	String? result;

	MangaCheck({this.result});

	factory MangaCheck.fromJson(Map<String, dynamic> json) => MangaCheck(
				result: json['result'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'result': result,
			};
}
