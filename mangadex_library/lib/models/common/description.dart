///@nodoc
class Description {
  late final String en;
  late final String fr;
  Description(this.en, this.fr);
  Description.fromJson(Map<String, dynamic> json) {
    en = json['en'] ?? '';
    fr = json['fr'] ?? '';
  }
}
