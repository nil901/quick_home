class OfferModel {
  final int id;
  final int categoryId;
  final String name;
  final String? description;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String? image;
  final String? imageUrl;

  OfferModel({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.image,
    this.imageUrl,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      image: json['image'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'category_id': categoryId,
    'name': name,
    'description': description,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'image': image,
    'image_url': imageUrl,
  };
}
