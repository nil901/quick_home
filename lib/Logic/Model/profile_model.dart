class ProfileModel {
  int id;
  String name;
  String email;
  String phone;
  String? image;
  String? emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String role;
  int active;
  int isDeleted;
  String? deletedAt;
  String averageRating;
  String? address;
  String? imageUrl;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.image,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.active,
    required this.isDeleted,
    this.deletedAt,
    required this.averageRating,
    this.address,
    this.imageUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      role: json['role'] ?? '',
      active: json['active'] ?? 0,
      isDeleted: json['is_deleted'] ?? 0,
      deletedAt: json['deleted_at'],
      averageRating: json['average_rating'] ?? '0.0',
      address: json['address'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'role': role,
      'active': active,
      'is_deleted': isDeleted,
      'deleted_at': deletedAt,
      'average_rating': averageRating,
      'address': address,
      'image_url': imageUrl,
    };
  }
}
