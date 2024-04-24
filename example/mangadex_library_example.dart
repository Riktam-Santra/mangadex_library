import 'package:mangadex_library/mangadex_client.dart';
import 'package:mangadex_library/mangadex_server_exception.dart';
import 'package:mangadex_library/src/client_types/personal_client.dart';

void main() {
  printFilenames();
}

void printFilenames() async {
  const clientId = 'YOUR_CLIENT_ID';
  const clientSecret = 'YOUR_CLIENT_SECRET';
  final client =
      MangadexPersonalClient(clientId: clientId, clientSecret: clientSecret);
  // this function, needs a mangadex account username and password supplied
  // to retrive login token
  var username = 'USERNAME'; // Put your username here
  var password = 'PASSWORD'; // Put your password here

  //The line below uses the login function and takes in
  //two String parameters, username and password and returns
  //an instance of the Login class
  try {
    //This login functions logs the user in and sets the login tokens.
    await client.login(username, password);

    var searchData = await client.search(
        query:
            'oregairu'); //This is a search function that queries mangadex for the name of a manga
    // it returns a Search class instance
    // For now, it searches for the Oregairu manga. You may replace the String value with your desired query.

    var mangaID = searchData.data![0]
        .id; // this line gets the manga ID from the instance of the Search we just obtained
    //for demonstration we are talking the manga ID of only the first search result
    //Manga ID is unique to every manga and therefore is required to obtain any information regarding it
    //For example, chapter pages and thumbnails.
    var chapterData = await client.getChapters(
        mangaID!); //This function returns an instance of the ChapterData class,
    // it contains info on all the chapters of the manga ID it has been provided.

    var chapterID = chapterData.data![0]
        .id; // This line sets the chapterID variable to the chapter id of
    // the first chapter from the chapterData we just got.
    //Every chapter has a usique chapter ID and a chapter Hash
    //Chapter ID is required to access info of the desired chapter.
    //Chapter Hash is required for requesting manga pages.
    //All Chapter Hash and Chapter filenames can be requested by using the getBaseUrl() function
    var baseUrl = await client.getBaseUrl(chapterID!);
    //This look prints all urls to all the pages of the chapterID
    baseUrl.chapter!.dataSaver!.forEach((filename) {
      print(client.constructPageUrl(
          baseUrl.baseUrl!, true, baseUrl.chapter!.hash!, filename));
    });
  } on MangadexServerException catch (e) {
    e.info.errors!.forEach((error) {
      print(error
          .title); // print error details if a server exception occurs (like invalid username or password)
      print(error.detail);
    });
  }
  //disposing of client is needed as the refresh timer will still be running.
  client.dispose();
}
