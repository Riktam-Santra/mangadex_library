A [dart library](https://pub.dev/packages/mangadex_library) to facilitate easier access to the [mangadex API](https://api.mangadex.org)

## WARNING! In progress library

The library is currently in an **under development and gradually changing** state and therefore doesn't contain many of the features and new features and bugs are added often, they will be added in the future. At the current state of the library, it is able to:

- Get login refresh and session tokens
- Logout user
- Search for Mangas
- Get Manga thumbnails/covers
- Get manga chapters
- Retieve Manga pages
- Get logged in user data
- Get a user's details
- Get an author's details
- Manage Custom Lists
- Check/Follow/Unfollow a Manga/Group/User
- Set/Get the reading status of a manga for the logged in user
- Get, Create and Delete Scanlation Groups

## Quickstart

A quick demonstration of the API:

```dart
import 'package:mangadex_library/mangadexServerException.dart';
import 'package:mangadex_library/mangadex_library.dart' as lib;

void main() {
  printFilenames();
}

void printFilenames() async {
  // this function, needs a mangadex account username and password supplied
  // to retrive login token
  var username = 'USERNAME'; // Put your username here
  var password = 'PASSWORD'; // Put your password here

  //The line below uses the login function and takes in
  //two String parameters, username and password and returns
  //an instance of the Login class
  try {
    var loginData = await lib.login(username, password);
    var token = loginData.token
        .session; // this sets the token variable to store the session token obtained using
    //the login function, it is a String value.
    // The token is used to access various sections and therefore it is recommended to be made accessible at all times.

    var searchData = await lib.search(
        query:
            'oregairu'); //This is a search function that queries mangadex for the name of a manga
    // it returns a Search class instance
    // For now, it searches for the Oregairu manga. You may replace the String value with your desired query.

    var mangaID = searchData.data[0]
        .id; // this line gets the manga ID from the instance of the Search we just obtained
    //for demonstration we are talking the manga ID of only the first search result
    //Manga ID is unique to every manga and therefore is required to obtain any information regarding it
    //For example, chapter pages and thumbnails.
    var chapterData = await lib.getChapters(
        mangaID); //This function returns an instance of the ChapterData class,
    // it contains info on all the chapters of the manga ID it has been provided.

    var chapterID = chapterData.data[0]
        .id; // This line sets the chapterID variable to the chapter id of
    // the first chapter from the chapterData we just got.
    //Every chapter has a usique chapter ID and a chapter Hash
    //Chapter ID is required to access info of the desired chapter.
    //Chapter Hash is required for requesting manga pages.
    //All Chapter Hash and Chapter filenames can be requested by using the getBaseUrl() function
    var baseUrl = await lib.getBaseUrl(chapterID);
    //This look prints all urls to all the pages of the chapterID
    baseUrl.chapter.dataSaver.forEach((filename) {
      print(lib.constructPageUrl(
          baseUrl.baseUrl, true, baseUrl.chapter.hash, filename));
    });
  } on MangadexServerException catch (e) {
    e.info.errors.forEach((error) {
      print(error
          .title); // print error details if a server exception occurs (like invalid username or password)
      print(error.detail);
    });
  }
}

```

## Documentation

The documentation is still under progress using the [wiki](https://github.com/Riktam-Santra/mangadex_library/wiki), I have planned to put in a detailed one and so it will take time.
for now the generated html docs using [dartdoc](https://pub.dev/packages/dartdoc) can be found in the doc/api/ folder.

## Contact

I'm not always active on github but you can always find me on discord, my ID: Rick~#9387