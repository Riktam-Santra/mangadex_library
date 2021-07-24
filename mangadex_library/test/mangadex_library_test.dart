import 'package:mangadex_library/mangadex_library.dart';

void main() async {
  // The code below is to demonstrate the search() function,
  //it takes in a String attriute 'query'.
  //It prints the title and Manga ID of all

  var query = 'PUT_A_SEARCH_QUERY_HERE'; // Put your search query here.
  var searchData = await search(query);
  print('Title and ID of all manga found: \n');
  for (var i = 0; i < searchData.results.length; i++) {
    //This for loop prints the Title and ID
    //of all the manga returned by the search() function.
    print('Title: ' + searchData.results[i].data.attributes.title.en);
    print('Manga ID: ' + searchData.results[i].data.id);
  }

  //The code below prints out the url to the first page of the first chapter of a manga
  //it takes in 3 prameters in total
  //The id of the manga (use the search function to get it)
  //and your mangadex username and password
  //the username and password are required to generated tokens.

  var id = 'PUT_A_MANGAID_HERE'; // Put the manga id here.
  var chapters = await getChapters(id);
  var chapId = chapters.result[0].data.id;
  print('Chapter ID: ' + chapId);
  var chapHash = chapters.result[0].data.attributes.hash;
  print('Chapter Hash: ' + chapHash);
  var filename = chapters.result[0].data.attributes.chapterData[0];
  var response = await login(
      'USERNAME', 'PASSWORD'); // Put your username and password here.
  var token = response.token.session;
  var baseUrl = 'https://uploads.mangadex.org';
  print('Token: ' + token);
  print('Url: $baseUrl/$token/data/$chapHash/$filename');
}
