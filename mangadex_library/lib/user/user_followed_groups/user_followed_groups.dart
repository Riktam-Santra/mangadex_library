import 'result.dart';

class UserFollowedGroups {
	List<Result>? results;
	int? limit;
	int? offset;
	int? total;

	UserFollowedGroups({this.results, this.limit, this.offset, this.total});

	factory UserFollowedGroups.fromJson(Map<String, dynamic> json) => UserFollowedGroups(
				results: (json['results'] as List<dynamic>?)
						?.map((e) => Result.fromJson(e as Map<String, dynamic>))
						.toList(),
				limit: json['limit'] as int?,
				offset: json['offset'] as int?,
				total: json['total'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'results': results?.map((e) => e.toJson()).toList(),
				'limit': limit,
				'offset': offset,
				'total': total,
			};
}
