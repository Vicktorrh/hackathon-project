import 'dart:convert';

class UserModel {
  final String email;
  final String profilePic;
  final bool seller;
  final int totalPrice;
  UserModel(
      {required this.email,
      required this.profilePic,
      required this.seller,
      required this.totalPrice});

  UserModel copyWith({
    String? email,
    String? profilePic,
    bool? seller,
    int? totalPrice,
  }) {
    return UserModel(
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      seller: seller ?? this.seller,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'profilePic': profilePic,
      'seller': seller,
      "totalPrice": totalPrice,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      profilePic: map['profilePic'] as String,
      seller: map['seller'] as bool,
      totalPrice: map['totalPrice'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(email: $email, profilePic: $profilePic, seller: $seller)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.profilePic == profilePic &&
        other.seller == seller;
  }

  @override
  int get hashCode => email.hashCode ^ profilePic.hashCode ^ seller.hashCode;
}
