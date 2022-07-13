///@nodoc
class AltTitles {
  late final String en;
  late final String fr;
  AltTitles(this.en, this.fr);
  AltTitles.fromJson(Map<String, dynamic> json) {
    en = json['en'] ?? '';
    fr = json['fr'] ?? '';
  }

  Map<String, dynamic> toJson() => {
        'en': en,
        'fr': fr,
      };
}
