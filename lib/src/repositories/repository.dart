import 'package:mangadex_library/src/repositories/at_home_repository.dart';
import 'package:mangadex_library/src/repositories/auth_repository.dart';
import 'package:mangadex_library/src/repositories/author_repository.dart';
import 'package:mangadex_library/src/repositories/chapter_repository.dart';
import 'package:mangadex_library/src/repositories/cover_repository.dart';
import 'package:mangadex_library/src/repositories/group_repository.dart';
import 'package:mangadex_library/src/repositories/list_repository.dart';
import 'package:mangadex_library/src/repositories/manga_repository.dart';
import 'package:mangadex_library/src/repositories/user_repository.dart';

class Repositories {
  final AtHomeRepository atHome;
  final AuthRepository auth;
  final AuthorRepository author;
  final ChapterRepository chapter;
  final CoverRepository cover;
  final GroupRepository group;
  final ListRepository list;
  final MangaRepository manga;
  final UserRepository user;

  Repositories()
      : atHome = AtHomeRepository(),
        auth = AuthRepository(),
        author = AuthorRepository(),
        chapter = ChapterRepository(),
        cover = CoverRepository(),
        group = GroupRepository(),
        list = ListRepository(),
        manga = MangaRepository(),
        user = UserRepository();
}
