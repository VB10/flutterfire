class UserRequest {
  String email;
  String password;
  bool returnSecureToken;

  UserRequest({this.email, this.password, this.returnSecureToken});

  UserRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    returnSecureToken = json['returnSecureToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email+"@hwa.tr";
    data['password'] = this.password;
    data['returnSecureToken'] = this.returnSecureToken;
    return data;
  }
}
