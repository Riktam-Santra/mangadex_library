class Login {
  late final String result;
  late final Token token;
  Login(this.result, this.token);
  Login.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    if (result == 'ok') {
      token = Token.fromJson(json['token']);
    } else {
      print(result);
    }
  }
}

class Token {
  late final String session;
  late final String refresh;
  Token(this.session, this.refresh);
  Token.fromJson(Map<String, dynamic> json) {
    session = json['session'] ?? '';
    refresh = json['refresh'] ?? '';
  }
}
