
class Address {
  final int id;
  final int userId;
  final String? contactDetails;
  final String? addressDetails;
  final String? type;
  final bool isDefault;
  final String? createdAt;
  final String? updatedAt;
  final User? user;

  Address({
    required this.id,
    required this.userId,
    this.contactDetails,
    this.addressDetails,
    this.type,
    required this.isDefault,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      contactDetails: json['contact_details'],
      addressDetails: json['address_details'],
      type: json['type'],
      isDefault: json['is_default'] ?? false,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'contact_details': contactDetails,
        'address_details': addressDetails,
        'type': type,
        'is_default': isDefault,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'user': user?.toJson(),
      };
}

class User {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? image;
  final String? role;
  final int? active;
  final int? isDeleted;
  final String? address;
  final String? imageUrl;

  User({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.image,
    this.role,
    this.active,
    this.isDeleted,
    this.address,
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      role: json['role'],
      active: json['active'],
      isDeleted: json['is_deleted'],
      address: json['address'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
        'role': role,
        'active': active,
        'is_deleted': isDeleted,
        'address': address,
        'image_url': imageUrl,
      };
}
