import 'dart:convert';

class AuthModel {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? bloodGroup;
  final int? phoneNumber;
  final int? age;
  final dynamic photoUrl;

  AuthModel({
    this.uid,
    this.email,
    this.displayName,
    this.bloodGroup,
    this.phoneNumber,
    this.age,
    this.photoUrl,
  });

  AuthModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? bloodGroup,
    int? phoneNumber,
    int? age,
    dynamic photoUrl,
  }) =>
      AuthModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        age: age ?? this.age,
        photoUrl: photoUrl ?? this.photoUrl,
      );

  factory AuthModel.fromRawJson(String str) =>
      AuthModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      uid: json["uid"] as String?,
      email: json["email"] as String?,
      displayName: json["displayName"] as String?,
      bloodGroup: json["bloodGroup"] as String?,
      phoneNumber: json["phoneNumber"] != null
          ? int.tryParse(json["phoneNumber"].toString())
          : null,
      age: json["age"] != null ? int.tryParse(json["age"].toString()) : null,
      photoUrl: json["photoUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "displayName": displayName,
        "bloodGroup": bloodGroup,
        "phoneNumber": phoneNumber,
        "age": age,
        "photoUrl": photoUrl,
      };
}
