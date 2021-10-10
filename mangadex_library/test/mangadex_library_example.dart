import 'package:mangadex_library/mangadex_library.dart';

void main() async {
  var token = await login('riksantra', 'Sikkim123.');
  var mangadata = await getAllUserMangaReadingStatus(token!.token.session);
  mangadata.statuses.forEach((key, value) {
    print('$key : $value');
  });
}
