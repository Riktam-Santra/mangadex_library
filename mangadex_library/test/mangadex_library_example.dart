import 'package:mangadex_library/mangadex_library.dart';
import 'package:mangadex_library/src/models/common/reading_status.dart';

void main() async {
  var token = await login('riksantra', 'Sikkim123.');
  var readChapters = await getAllReadChapters(
      token!.token.session, '801513ba-a712-498c-8f57-cae55b38cc92');
  print(readChapters.data.length);
}
