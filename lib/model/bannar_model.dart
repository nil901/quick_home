class BannerModel {
  String imageUrl;

  BannerModel({required this.imageUrl});

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      BannerModel(imageUrl: json['image_url']);

  Map<String, dynamic> toJson() => {'image_url': imageUrl};
}
