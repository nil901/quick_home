class LoginModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  LoginModel({this.success, this.statusCode, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? otp;
  User? user;
  String? token;

  Data({this.otp, this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  Null? image;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? role;
  int? active;
  int? isDeleted;
  Null? deletedAt;
  Null? address;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.active,
    this.isDeleted,
    this.deletedAt,
    this.address,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'];
    active = json['active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['role'] = this.role;
    data['active'] = this.active;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['address'] = this.address;
    return data;
  }
}
