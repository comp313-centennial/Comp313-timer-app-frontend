class LoginCredentials {
  String email;
  String password;

  LoginCredentials({
    this.email,
    this.password,
  });

  @override
  String toString() {
    return 'LoginDto{email: $email, password: $password}';
  }

  factory LoginCredentials.fromJson(Map<String, dynamic> json) {
    return LoginCredentials(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}
