class GroupCheck {
	String? result;

	GroupCheck({this.result});

	factory GroupCheck.fromJson(Map<String, dynamic> json) => GroupCheck(
				result: json['result'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'result': result,
			};
}
