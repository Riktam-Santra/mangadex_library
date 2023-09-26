class TokenException implements Exception {
  late String info;

  TokenException(this.info) {
    print(info);
  }
}
