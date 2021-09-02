import 'data.dart';

class Result {
	String? result;
	Data? data;

	Result({this.result, this.data});

	factory Result.fromJson(Map<String, dynamic> json) => Result(
				result: json['result'] as String?,
				data: json['data'] == null
						? null
						: Data.fromJson(json['data'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'result': result,
				'data': data?.toJson(),
			};
}
