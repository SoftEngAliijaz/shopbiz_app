import 'dart:convert';

class UserModel {
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.avatar,
    required this.phoneNumber,
    this.isAdmin = false,
  });

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      avatar: map['avatar'],
      phoneNumber: map['phoneNumber'],
      isAdmin: map['isAdmin'] ?? false,
    );
  }

  String email;
  final bool isAdmin;
  String name;
  int phoneNumber;
  String avatar;
  String uid;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'avatar': avatar,
      'phoneNumber': phoneNumber,
      'isAdmin': isAdmin,
    };
  }

  String toJson() => json.encode(toMap());
}
