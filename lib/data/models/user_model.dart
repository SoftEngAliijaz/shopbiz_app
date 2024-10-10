import 'dart:convert';

class UserModel {
  String uid;
  String name;
  String email;
  String profilePic;
  String phoneNumber;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePic,
    required this.phoneNumber,
  });

  // Method to convert UserModel to a map (for Firebase)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'phoneNumber': phoneNumber,
    };
  }

  // Method to create a UserModel from a map (for Firebase)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      profilePic: map['profilePic'],
      phoneNumber: map['phoneNumber'],
    );
  }

  // Method to convert UserModel to a JSON string
  String toJson() => json.encode(toMap());

  // Method to create a UserModel from a JSON string
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
