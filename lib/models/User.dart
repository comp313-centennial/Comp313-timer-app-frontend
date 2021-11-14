class UserModel {
  UserModel({
    this.email,
    this.phoneNumber,
    this.displayName,
    this.bio
  });

  String email;
  String phoneNumber;
  String displayName;
  String bio;

  UserModel copyWith({
    String email,
    String phoneNumber,
    String displayName,
    String bio
  }) =>
      UserModel(
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        displayName: displayName ?? this.displayName,
        bio: bio ?? this.bio
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    displayName: json["displayName"],
    bio: json["bio"]
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "phoneNumber": phoneNumber,
    "displayName": displayName,
    "bio": bio,
  };
}
