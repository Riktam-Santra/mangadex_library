///@nodoc
class Name {
  late final String en;
  late final String fr;
  Name(this.en, this.fr);
  Name.fromJson(Map<String, dynamic> json) {
    en = json['en'] ?? '';
    fr = json['fr'] ?? '';
  }
  Map<String, dynamic> toJson() => {
        'en': en,
        'fr': fr,
      };
}
