import 'package:mangadex_library/mangadex_library.dart';

void main() async {
  // The code below is to demonstrate the search() function,
  // it takes in a String attriute 'query'.
  // It prints the title and Manga ID of all manga found

  var query = 'oregairu'; // Put your search query here.
  var searchData = await search(query: query);
  print('Title and ID of all manga found: \n');
  if (searchData != null) {
    for (var i = 0; i < searchData.data.length; i++) {
      //This for loop prints the Title and ID
      //of all the manga returned by the search() function.
      print('Title: ' + searchData.data[i].attributes.title.en);
      print('Manga ID: ' + searchData.data[i].id);
    }
  } else {
    print('Manga not found :(');
  }

  // The code below prints out the url to the first page of the first chapter of a manga
  // it takes in 3 prameters in total
  // The id of the manga (use the search function to get it)
  // and your mangadex username and password
  // the username and password are required to generated tokens.

  var id = 'MANGA_ID'; // Put the manga id here.
  var chapters = await getChapters(id);
  var chapId = chapters!.data[0].id;
  print('Chapter ID: ' + chapId);
  var chapHash = chapters.data[0].attributes.hash;
  print('Chapter Hash: ' + chapHash);
  var filename = chapters.data[0].attributes.chapterData[0];
  var response = await login(
      'USERNAME', 'PASSWORD.'); // Put your username and password here.
  if (response != null) {
    var token = response.token.session;
    var baseUrl = 'https://uploads.mangadex.org';
    print('Token: ' + token);
    print('Url: $baseUrl/$token/data/$chapHash/$filename');
    // the code below prints the file names of the 1st chapter
    var chapterFilenameList = await getChapterFilenames('$chapId', false);
    for (var i = 0; i < chapterFilenameList.length; i++) {
      print(chapterFilenameList[i]);
    }
  }
  var tokendata = await login('riksantra', 'Sikkim123.');
  print(tokendata!.token.session);
}
