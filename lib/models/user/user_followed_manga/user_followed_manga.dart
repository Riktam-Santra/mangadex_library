///@nodoc
import 'package:mangadex_library/models/common/data.dart';

class UserFollowedManga {
  late final List<Data> data;
  late final int limit;
  late final int offset;
  late final int total;
  UserFollowedManga(this.data, this.limit, this.offset, this.total);
  UserFollowedManga.fromJson(Map<String, dynamic> json) {
    data = <Data>[];

    json['data']!.forEach((v) {
      data.add(Data.fromJson(v));
    });

    limit = json['limit'] ?? 0;
    offset = json['offset'] ?? 0;
    total = json['total'] ?? 0;
  }
}
