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
 -  getChapterDataByChapterId() and  getMangaDataByMangaId() both shifted to jsonSearchCommands. None of them require a Chapter instance as a parameter anymore and are now Future functions.

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