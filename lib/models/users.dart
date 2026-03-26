class Users {
  final String name;
  final String email;
  final String password;
  final String profileImage;

  Users({
    required this.name,
    required this.email,
    required this.password,
    required this.profileImage,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      profileImage: json['profileImage'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password};
  }
}
