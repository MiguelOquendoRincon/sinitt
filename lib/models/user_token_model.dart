import 'dart:convert';

UserToken userTokenFromJson(String str) => UserToken.fromJson(json.decode(str));

String userTokenToJson(UserToken data) => json.encode(data.toJson());

class UserToken {
    UserToken({
        this.token,
        this.username,
        this.names,
        this.termsAccepted,
        this.tokenType,
        this.defaultUser,
    });

    String? token;
    String? username;
    String? names;
    bool? termsAccepted;
    String? tokenType;
    bool? defaultUser;

    factory UserToken.fromJson(Map<String, dynamic> json) => UserToken(
        token: json["token"],
        username: json["username"],
        names: json["names"],
        termsAccepted: json["termsAccepted"],
        tokenType: json["tokenType"],
        defaultUser: json["defaultUser"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "username": username,
        "names": names,
        "termsAccepted": termsAccepted,
        "tokenType": tokenType,
        "defaultUser": defaultUser,
    };
}
