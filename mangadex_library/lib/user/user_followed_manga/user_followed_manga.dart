import 'package:mangadex_library/search/Search.dart';

class UserFollowedManga {
  late final List<Results> results;
  late final int limit;
  late final int offset;
  late final int total;
  UserFollowedManga(this.results, this.limit, this.offset, this.total);
  UserFollowedManga.fromJson(Map<String, dynamic> json) {
    results = <Results>[];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
    limit = json['limit'] ?? 0;
    offset = json['offset'] ?? 0;
    total = json['total'] ?? 0;
  }
}
