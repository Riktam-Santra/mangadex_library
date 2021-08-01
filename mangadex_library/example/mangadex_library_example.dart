import 'package:mangadex_library/mangadex_library.dart';
import 'dart:io';

void main() async {
  print('Enter a search query: ');
  var query = stdin.readLineSync();
  var searchData = await search(query ?? '');
  print('Title of all manga found: \n');
  for (var i = 0; i < searchData.results.length; i++) {
    print(searchData.results[i].data.attributes.title.en);
  }
}
