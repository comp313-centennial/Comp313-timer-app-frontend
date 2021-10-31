import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.email,
    this.phoneNumber,
    this.displayName,
  });

  String email;
  String phoneNumber;
  String displayName;

  UserModel copyWith({
    String email,
    String phoneNumber,
    String displayName,
  }) =>
      UserModel(
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        displayName: displayName ?? this.displayName,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    displayName: json["displayName"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "phoneNumber": phoneNumber,
    "displayName": displayName,
  };
}
