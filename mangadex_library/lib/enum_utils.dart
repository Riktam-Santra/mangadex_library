import 'package:mangadex_library/models/common/manga_status.dart';
import 'package:mangadex_library/models/common/publication_demographic.dart';
import 'package:mangadex_library/models/common/tag_modes.dart';

import 'models/common/content_rating.dart';
import 'models/common/future_updates.dart';
import 'models/common/language_codes.dart';
import 'models/common/reading_status.dart';

abstract class EnumUtils {
  static String parseStatusFromEnum(ReadingStatus status) {
    switch (status) {
      case ReadingStatus.completed:
        return 'completed';
      case ReadingStatus.dropped:
        return 'dropped';
      case ReadingStatus.on_hold:
        return 'on_hold';
      case ReadingStatus.plan_to_read:
        return 'plan_to_read';
      case ReadingStatus.re_reading:
        return 're_reading';
      case ReadingStatus.reading:
        return 'reading';
    }
  }

  static String parseLanguageCodeFromEnum(LanguageCodes code) {
    switch (code) {
      case LanguageCodes.en:
        return 'en';
      case LanguageCodes.es:
        return 'es';
      case LanguageCodes.es_la:
        return 'es-la';
      case LanguageCodes.ja_ro:
        return 'ja-ro';
      case LanguageCodes.ko_ro:
        return 'ko-ro';
      case LanguageCodes.pt_br:
        return 'pt-br';
      case LanguageCodes.zh:
        return 'zh';
      case LanguageCodes.zh_hk:
        return 'zh-hk';
      case LanguageCodes.zh_ro:
        return 'zh-ro';
    }
  }

  static String parseContentRatingFromEnum(ContentRating rating) {
    switch (rating) {
      case ContentRating.erotica:
        return 'erotica';
      case ContentRating.pornographic:
        return 'pornographic';
      case ContentRating.safe:
        return 'safe';
      case ContentRating.suggestive:
        return 'suggestive';
    }
  }

  static String parseFutureUpdatesFromEnum(FutureUpdates update) {
    switch (update) {
      case FutureUpdates.enable:
        return '1';
      case FutureUpdates.disable:
        return '2';
    }
  }

  static String parseMangaStatusFromEnum(MangaStatus status) {
    switch (status) {
      case MangaStatus.ongoing:
        return 'ongoing';
      case MangaStatus.haitus:
        return 'haitus';
      case MangaStatus.completed:
        return 'completed';
      case MangaStatus.cancelled:
        return 'cancelled';
    }
  }

  static String parseTagModeFromEnum(TagsMode tagmode) {
    switch (tagmode) {
      case TagsMode.Or:
        return 'OR';
      case TagsMode.And:
        return 'AND';
    }
  }

  static String parsePublicDemographicFromEnum(PublicDemographic demographic) {
    switch (demographic) {
      case PublicDemographic.josei:
        return 'josei';
      case PublicDemographic.none:
        return 'none';
      case PublicDemographic.seinen:
        return 'seinen';
      case PublicDemographic.shoujo:
        return 'shoujo';
      case PublicDemographic.shounen:
        return 'shounen';
    }
  }
}
