class ServicesModel {
  int id;
  int categoryId;
  int subcategoryId;
  String name;
  String description;
  // String? whatsInclude;
  String? shortDescription;
  String? priceOnetime;
  String? priceOnetimeDesc;
  String? priceWeekly;
  String? priceWeeklyDesc;
  String? priceMonthly;
  String? priceMonthlyDesc;
  String? priceYearly;
  String? priceYearlyDesc;
  bool isArabic;
  String duration;
  String status;
  bool qwikpick;
  bool beautyAndEasy;
  String? image;
  String? imageUrl;
  double? averageRating;
  int? totalReviews;
  bool? isWishlisted;

  ServicesModel({
    required this.id,
    required this.categoryId,
    required this.subcategoryId,
    required this.name,
    required this.description,
    // this.whatsInclude,
    this.shortDescription,
    this.priceOnetime,
    this.priceOnetimeDesc,
    this.priceWeekly,
    this.priceWeeklyDesc,
    this.priceMonthly,
    this.priceMonthlyDesc,
    this.priceYearly,
    this.priceYearlyDesc,
    required this.isArabic,
    required this.duration,
    required this.status,
    required this.qwikpick,
    required this.beautyAndEasy,
    this.image,
    this.imageUrl,
    this.averageRating,
    this.totalReviews,
    this.isWishlisted,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
    id: json['id'],
    categoryId: json['category_id'],
    subcategoryId: json['subcategory_id'],
    name: json['name'],
    description: json['description'] ?? '',
    // whatsInclude: json['whats_include'],
    shortDescription: json['short_description'],
    priceOnetime: json['price_onetime'],
    priceOnetimeDesc: json['price_onetime_desc'],
    priceWeekly: json['price_weekly'],
    priceWeeklyDesc: json['price_weekly_desc'],
    priceMonthly: json['price_monthly'],
    priceMonthlyDesc: json['price_monthly_desc'],
    priceYearly: json['price_yearly'],
    priceYearlyDesc: json['price_yearly_desc'],
    isArabic: json['is_arabic'] ?? false,
    duration: json['duration'] ?? '',
    status: json['status'] ?? '',
    qwikpick: json['qwikpick'] ?? false,
    beautyAndEasy: json['beauty_and_easy'] ?? false,
    image: json['image'],
    imageUrl: json['image_url'],
    averageRating: json['average_rating']?.toDouble(),
    totalReviews: json['total_reviews'],
    isWishlisted: json['is_wishlisted'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'category_id': categoryId,
    'subcategory_id': subcategoryId,
    'name': name,
    'description': description,
    'short_description': shortDescription,
    'price_onetime': priceOnetime,
    'price_onetime_desc': priceOnetimeDesc,
    'price_weekly': priceWeekly,
    'price_weekly_desc': priceWeeklyDesc,
    'price_monthly': priceMonthly,
    'price_monthly_desc': priceMonthlyDesc,
    'price_yearly': priceYearly,
    'price_yearly_desc': priceYearlyDesc,
    'is_arabic': isArabic,
    'duration': duration,
    'status': status,
    'qwikpick': qwikpick,
    'beauty_and_easy': beautyAndEasy,
    'image': image,
    'image_url': imageUrl,
    "is_wishlisted": isWishlisted,
    "average_rating": averageRating,
    "total_reviews": totalReviews,
  };
}
