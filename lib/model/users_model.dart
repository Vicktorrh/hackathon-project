import 'dart:convert';

class UserModel {
  final String email;
  final String profilePic;
  UserModel({required this.email, required this.profilePic});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'profilePic': profilePic,
    };
  }

  static UserModel? fromMap(Map<String, dynamic>? user) {
    if (user == null) return null;
    try {
      return UserModel(email: user['email'], profilePic: user['profilePic']);
    } catch (e) {
      return null;
    }
  }

  String toJson() => json.encode(toMap());

  static UserModel? fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
