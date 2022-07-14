## 1.0.0

- First release

## 1.0.1

- Minor fixes.

## 1.0.2

- Added JsonSearchCommands.dart, contains a few handy functions.
- Added getFileNames function to JsonSearchCommands, can return all the filenames of a specific chapter if chapter data and chapter ID is provided

## 1.0.3

- Added getChapterDataByChapterId function, returns an instance of Result class with chapter data of the chapter ID provided inside it. It requires a ChapterData instance.

## 1.0.4

- Chapter class name changed to ChapterData.

## 1.0.5

- Added ConstructThumbUrl function, it returns the uri to a thumbnail in the form of a String, it requires manga ID and cover filename.

## 1.0.6

- Changed class name jsonSearch to JsonSearch in jsonSearchCommands.dart
- Cdded a Quickstart in README.md until proper documentation is created.

## 1.0.7

- Cdded getCoverArt function to retrieve cover art details.

## 1.0.8

- Fixed issues while retireving cover art.

## 1.0.9

- Added resolution options to getCoverArtUrl. Can be '256', '512' or null

## 1.1.0

- Now prints 'Rate limit exceeded' if the rate limit is exceeded by the requests.

## 1.1.1

- All the functions that are to return a value are now nullable, that is if the results are empty (for example you search for a manga and no manga is found) the function will return null and print the results were not found.

## 1.1.2

- Minor fixes

## 1.1.3

- Minor info changes

## 1.1.4

- Disabled description class for TagAttributes because of an error, shouldn't be a concern as long as the description of a tag isn't required (note: the description here isn't the manga description.)

## 1.1.5

- Minor fixes

## 1.1.6

- getCoverArtUrl() no longer returns a nullable String.

## 1.1.7

- getChapterDataByChapterId() and getMangaDataByMangaId() both shifted to jsonSearchCommands. None of them require a Chapter instance as a parameter anymore and are now Future functions.

## 1.1.8

- added null handling for Login class.

## 1.1.9

- added refresh function to refresh token, returns a Login instance.

## 1.2.0

- minor fixes related to refresh.

## 1.2.1

- added options to set a limit and offset for getChapters function.

## 1.2.2

- added function getUserFollowedManga() to retrieve followed manga by the logged in user.

## 1.2.3

- added function checkIfUserFollowsManga() to check if a users follows a certain manga.
- added function getUserFollowedUsers() to retrieve followed users by the logged in user.
- added function checkIfUserFollowsUser() to check if a users follows a certain user.
- added function getUserFollowedGroups() to retrieve followed groups by the logged in user.
- added function checkIfUserFollowsGroup() to check if a users follows a certain group.
- added function getLoggedUserDetails() to get the profile details of the logged in user.

## 1.2.4

- fixed issues related to all the user specific functions in 1.2.3

## 1.2.5

- Added followManga() and unfollowManga() functions to follow / unfollow a manga.

## 1.2.6

- the functions checkIfUserFollowsManga() checkIfUserFollowsUser() and checkIfUserFollowsGroup() now return a bool rather than a MangaCheck.

## 1.2.7

- minor bug fixes.

## 1.2.7+1

- minor bug fixes

## 1.2.7+2

- fixed bug where search would return null despite having results.

## 1.2.8

- Model classes updated and rearranged according to the JSON structure changes in Mangadex API 5.2.35.

## 1.2.8+1

- Fixed problems with JsonSearch.

## 1.2.8+2

- Changed Cover model class according to Mangadex API update 5.2.35

## 1.2.8+3

- User data models related changes according to Mangadex API update 5.2.35

## 1.2.9

- fixed all major bugs related to Mangadex API update 5.2.35

## 1.2.9+1

- minor bug fixes related to login.

## 1.2.9+2

- even more bug fixes related to chapterData.

## 1.2.9+3

- more bug fixes related to chapterData.

## 1.2.9+4

- fixed errors in model classes(again)

## 1.2.9+5

- tried fixing the data model for getMangaDataByMangaId()

## 1.2.9+6

- finally fixed the data model for getMangaDataByMangaId()

## 1.2.9+7

- fixed issues related to getChapterFilenames() in JsonSearch

## 1.2.10

- added getAllMangaReadingStatus() and getMangaReadingStatus() functions
- fixed getLoggedUserDetails() function

## 1.2.10+1

- minor changes related to UserDetails model class.

## 1.2.10+2

- more changes related to UserDetails model class.

## 1.2.10+3

- more changes related to UserDetails model class.

## 1.2.10+4

- more changes related to UserDetails model class (I swear it's working this time)

## 1.2.11

- added getAllReadChapters(), markChapterRead(), markChapterUnread(), markMultileChaptersRead() and markMultileChaptersUnread functions

## 1.2.12

- added offset and limit parameters to getUserFollowedManga(),getUserFollowedGroups() and getUserFollowedUsers() functions

## 1.2.13

- fixed a few typos in the check functions for user followed responses.

## 1.2.13+1

- fixed typos related to follow and unfollow manga

## 1.2.14

- renamed function getAllMangaReadingStatus() to getAllUserMangaReadingStatus
- fixed type errors when paring json for function getAllUserMangaReadingStatus()

## 1.2.15

- added getMangaReadingStatus() to get reading status of a certain manga ID.
- added setMangaReadingStatus() to set reading status of a certain manga ID.
- moved all model classes to src folder to make the code more organised.
- started work on wiki documentation on github (it will take time to finish it) https://github.com/Riktam-Santra/mangadex_library/wiki.

## 1.2.16

- fixed a cast on null error in getAllReadChapters()

## 1.2.17

- revoked the move of all models into src/ folder (see point 3 of 1.2.15).
- added enum ReadingStatus to keep the values of reading status fixed.
- added removeMangaReadingStatus() to remove the reading status of a manga but still keep it as followed.
- using followManga() now automatically sets the reading status for the manga as 'reading', this can can be changed to other status by supplying the optional ReadingStatus enum. It is not possible to asign a null value to the status, this can be done using the removeMangaReadingStatus().
- using unfollowManga() now first removes the reading status and then unfollows the manga (just to be on the safe side).
- changed class name JsonSearchCommands() to JsonUtils(), the class can no longer be instantiated since all of it's functions are now static.

## 1.2.18

- fixed a typo which broke getCoverArtUrl() function when requesting for different resolutions.

## 1.2.19

- added reportImageStatus() function, read [here](https://api.mangadex.org/docs.html#section/Report) to understand it's use.<br> _Note: this is **not** the user image reporting function but rather to report whether an image was successfully recieved from the server or not._

## 1.2.20

- using unfollowManga() no longer removes the manga status first.

## 1.2.21

- getAllUserMangaReadingStatus() now takes in an optional ReadingStatus parameter to get manga with only a certain reading status.

## 1.2.22

- fixed a type error in AllMangaReadingStatus model class while parsing data.

## 1.2.23

- fixed setMangaReadingStatus function.

## 1.2.24

- fixed issues with markChapterRead(), markChapterUnread(), getAllReadChapters(), getAllReadChaptersForAListOfManga() and markMultipleChaptersRead().

## 1.2.25

- removed option to set manga reading status for a manga as null.

## 1.2.26

- fixed unfollowManga() not unfollowing manga.

## 1.2.27

- getChapters() now supports the following parameters:
  ids, groups, title, uploader, manga, volume, chapter, translated language, original language, excluded original language, content rating, include future updates, created at since, updated at since, published at since, includes.
- added enums:
  ContentRating, FutureUpdates and LanguageCodes.

## 1.2.28

- added MangadexServerException to handle server exceptions
- every model class now throws a MangadexServerException that can be caught and will contain a ServerException class which will have error details as returned by the server (including the response code).
- updated /test/mangadex_library_example.dart with error handling.

## 1.2.29

- Updated according to the changes in Mangadex API update [5.4.8](https://discord.com/channels/403905762268545024/839817812012826644/929319168958955554)
- getChapterDataByChapterID() function is now to be used to get chapter filenames, base url and chapter hash.
- **Removed** class JsonUtils.
- Moved getChapterFilenames(), getChapterDataByChapterId() and getMangaDataByMangaId() functions to mangadex_library.dart.

## 1.2.30

- Added all filter parameters for search function.
- **Search function parameters changed to named parameters.** Previously `search('manga name')`, now `search(query: 'manga name')`
- All parameters are now optional for search function. Query parameter is no longer required to use search functions.
- Created enums MangaStatus, PublicationDemographic, TagsMode to fix values for search parameters.
- Created abstract class EnumUtils.
- All fuctions used to parse enums to Strings and vice versa are transferred to EnumUtils.
- **Deleted** JsonUtils class.
- Created Model class for BaseUrl returned by `getBaseUrl()` to parse response from get /at-home/server endpoint. `ConstructPageUrl()` can be used to construct page urls using data provided by the BaseUrl class.

## 1.3.0

- Added proper comment documentation to all functions.
- Renamed ResultOk model class to Result.
- **Deleted** the MangaCheck model class, replaced by Result class.
- All functions now throw the MangadexServerException exception rather than the model classes themselves.
- Moved mangadex_library_example from /test to /example directory.

## 1.3.1 (Handling for Custom List Endpoints)
- Added getUserFeed() function to get User's feed and return the data in a UserFeed class instance.
- Added functions: getLoggedInUserCustomLists(), getUserCustomLists(), createCustomList(), getCustomList(),updateCustomList(), deleteCustomList(), followCustomList(), unfollowCustomList(), addMangaToCustomList(), removeMangaFromCustomList(), getUserCustomLists().
- Created enum Visibility.
- Created enum_utls function parseVisibilityFromEnum().

## 1.3.2 (Stared Function for Author Data)
- Added model class AuthorSearchResult.
- Added function searchAuthor() to search for authors, returns a AuthorSearchResult class instance.
- Added model lass AuthorInfo
- Added function getAuthorById() to get author data by their UUID, returns an AuthorInfo class Instance.
**Note:** documentation has not been updated for this patch, it will be updated after all features of the /author endpoint implemented.

## 1.3.3
- Fixed problems with AuthorInfo model class.

## 1.3.4
- Fixed even more problems with AuthorInfo model class.

## 1.3.5
- Added Order parameter to search() function.

## 1.3.6
- Removed 'biography' field from AuthorInfo model class until a known bug is solved.

## 1.3.7
- Added documentation for all functions added since 1.3.1

## 1.3.8
- Added logout() function for endpoint /auth/logout

## 1.3.9
- Added getScanlationGroupResponse(), getScanlationGroup(), getScanlationGroupById(), getScanlationGroupByIdResponse(), createScanlationGroupResponse(), and createScanlationGroupResponse() functions.

## 1.3.10
- Fixed critical searchResponse() and getScanlationGroupResponse() related [issues](https://github.com/Riktam-Santra/mangadex_library/issues/2). 
- getCoverArt() and getCoverArtResponse() now take in mangaIds and coverIds parameters as `List<String>` which was previously just String values.
- added locales, uploaders, order, limit, offset parameters to getCoverArt() and getCoverArtResponse
- changed search() function's **query parameter name to 'title'**

## 1.3.11
- Fixed multiple problems with json parsing in the Data class under [scanlationsResult.dart](https://github.com/Riktam-Santra/mangadex_library/blob/main/mangadex_library/lib/models/scanlation/scanlationsResult.dart)
- Added /test/test.dart for testing.

## 1.3.12 
- Removed package 'test' as a dependency due to incompability with flutter.
- Slightly updated the documentation.
- Deleted /test/test.dart

## 1.3.13
- Fixed getCoverArt() function where limit and offset were set to null.

## 1.3.14
- Fixed getCoverArtUrl() function adding `[]` brackets around the manga id it was supplied to.
- getCoverArt() now returns a `List<String>` (previously `String`).

## 1.3.15
- Added getMangaAggregate() function to get details about the volumes and chapters of a manga.

## 1.3.16
- Fixed a typo in the Search.dart model class mentioned in one of the [issues](https://github.com/Riktam-Santra/mangadex_library/issues/3).
- The constructPageUrl() function no longer required the session token argument.
- Fixed a bug where the constructPageUrl() fuction returned forbidden addresses.
- Updated the example on the readme page to the latest changes.

## 1.3.17
- Added result and resource fields to ChapterData model class.
- Order parameters of all functions now take a Map of Enums rather than String values, for example an order for search was previously
  ```dart
  search(
    order: {'createdAt':'asc'},
  );
  ```
  HAS BEEN CHANGED TO
  ```dart
  search(
        orders: {SearchOrders.createdAt: OrderDirections.ascending},
      );
  ```
  I'll try to write the documentation specifically for this part for now but feel free to ping me if you need any help.
- Created [order_enums.dart](/lib/models/common/order_enums.dart) to hold all possible order enums for order parameters of different functions.

## 1.3.18
- Fixed a null error in function `getAllUserMangaReadingStatus()` when not passing in any reading status.

## 1.3.19
- `getChapterFilenames` is now **Depricated**. `getChapterDataByChapterId()` should be used instead.
- Fixed a cast error in AllMangaReadingStatus model class.

## 1.4.0
- Added `toJson()` method to most the important model classes.
- Removed the unnecessary root folder (changed from mangadex_libray/mangadex_libray/ to mangadex_library/).
- Updated documentation of `constructPageUrl()`, I had forgotten to remove the use of session token from it's documentation.

## 1.4.1
- Added `toJson()` to all model classes.
