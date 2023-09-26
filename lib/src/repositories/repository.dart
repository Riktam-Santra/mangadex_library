import 'package:mangadex_library/src/repositories/at_home_repository.dart';
import 'package:mangadex_library/src/repositories/auth_repository.dart';
import 'package:mangadex_library/src/repositories/author_repository.dart';
import 'package:mangadex_library/src/repositories/chapter_repository.dart';
import 'package:mangadex_library/src/repositories/cover_repository.dart';
import 'package:mangadex_library/src/repositories/group_repository.dart';
import 'package:mangadex_library/src/repositories/list_repository.dart';
import 'package:mangadex_library/src/repositories/manga_repository.dart';
import 'package:mangadex_library/src/repositories/user_repository.dart';

class Repositories
    with
        AuthRepository,
        AtHomeRepository,
        AuthorRepository,
        ChapterRepository,
        CoverRepository,
        GroupRepository,
        ListRepository,
        MangaRepository,
        UserRepository {}
