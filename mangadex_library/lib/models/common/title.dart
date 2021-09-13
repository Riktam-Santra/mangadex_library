class Title {
  late final String en;
  late final String fr;
  Title(this.en, this.fr);
  Title.fromJson(Map<String, dynamic> json) {
    en = json['en'] ?? '';
    fr = json['fr'] ?? '';
  }
}
