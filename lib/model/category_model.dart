
class CategoryModel {
  int id;
  String name;
  String? description;
  String status;
  String createdAt;
  String updatedAt;
  String? image;
  String? imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.image,
    this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        status: json['status'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        image: json['image'],
        imageUrl: json['image_url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'image': image,
        'image_url': imageUrl,
      };
}
