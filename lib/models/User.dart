class UserModel {
  UserModel({
    this.email,
    this.phoneNumber,
    this.displayName,
    this.bio,
    this.userType
  });

  String email;
  String phoneNumber;
  String displayName;
  String bio;
  String userType;

  UserModel copyWith({
    String email,
    String phoneNumber,
    String displayName,
    String bio,
    String userType
  }) =>
      UserModel(
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        displayName: displayName ?? this.displayName,
        bio: bio ?? this.bio,
        userType: userType ?? this.userType
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    displayName: json["displayName"],
    bio: json["bio"],
    userType: json["userType"]
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "phoneNumber": phoneNumber,
    "displayName": displayName,
    "bio": bio,
    "userType": userType
  };
}
