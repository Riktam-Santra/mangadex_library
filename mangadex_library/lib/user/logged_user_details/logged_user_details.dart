import 'data.dart';

class LoggedUserDetails {
	String? result;
	Data? data;

	LoggedUserDetails({this.result, this.data});

	factory LoggedUserDetails.fromJson(Map<String, dynamic> json) => LoggedUserDetails(
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
