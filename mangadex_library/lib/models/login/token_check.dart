class AuthenticationCheck {
  late String result;
  late bool isAuthenticated;
  late List<String> roles;
  late List<String> permissions;
  AuthenticationCheck(
      this.result, this.isAuthenticated, this.roles, this.permissions);
  AuthenticationCheck.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    isAuthenticated = json['isAuthenticated'] ?? false;
    roles = [];
    if (json['roles'] != null) {
      json['roles'].forEach((e) {
        roles.add(e);
      });
    }
    if (json['permissions'] != null) {
      json['permissions'].forEach((e) {
        roles.add(e);
      });
    }
  }
}
