class Links {
	String? property1;
	String? property2;

	Links({this.property1, this.property2});

	factory Links.fromJson(Map<String, dynamic> json) => Links(
				property1: json['property1'] as String?,
				property2: json['property2'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'property1': property1,
				'property2': property2,
			};
}
