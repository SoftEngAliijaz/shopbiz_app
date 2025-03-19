class UserUIModel {
  String? createdAt;
  String? name;
  String? avatar;
  String? updatedAt;
  String? email;
  String? city;
  String? id;
  String? phone;
  String? job;

  UserUIModel({
    this.createdAt,
    this.name,
    this.avatar,
    this.updatedAt,
    this.email,
    this.city,
    this.id,
    this.phone,
    this.job,
  });

  UserUIModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    name = json['name'];
    avatar = json['avatar'];
    updatedAt = json['updatedAt'];
    email = json['email'];
    city = json['city'];
    id = json['id'];
    phone = json['phone'];
    job = json['job'];
  }
}
