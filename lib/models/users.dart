class Users {
  final String name;
  final String email;
  final String pasword;
  final String profileImage;

  Users({
    required this.name,
    required this.email,
    required this.pasword,
    required this.profileImage,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'] as String,
      email: json['email'] as String,
      pasword: json['password'] as String,
      profileImage: json['profileImage'] as String,
    );
  }
}
