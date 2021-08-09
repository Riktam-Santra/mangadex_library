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
