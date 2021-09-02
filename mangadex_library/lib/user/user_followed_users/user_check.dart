class UserCheck {
	String? result;

	UserCheck({this.result});

	factory UserCheck.fromJson(Map<String, dynamic> json) => UserCheck(
				result: json['result'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'result': result,
			};
}
