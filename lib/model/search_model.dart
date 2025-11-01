class SearchModel {
  int? id;
  String? name;
  String? description;
  String? shortDescription;
  String? imageUrl;
  List<String>? mediaUrls;
  Category? category;
  Category? subcategory;
  Prices? prices;
  num? averageRating;
  int? totalReviews;
  bool? qwikpick;
  bool? isWishlisted;
  bool? beautyAndEasy;
  bool? isArabic;
  bool? hasOffers;
  String? createdAt;

  SearchModel({
    this.id,
    this.name,
    this.description,
    this.shortDescription,
    this.imageUrl,
    this.mediaUrls,
    this.category,
    this.subcategory,
    this.prices,
    this.averageRating,
    this.totalReviews,
    this.qwikpick,
    this.beautyAndEasy,
    this.isWishlisted,
    this.isArabic,
    this.hasOffers,
    this.createdAt,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      shortDescription: json['short_description'],
      imageUrl: json['image_url'],
      isWishlisted: json['is_wishlisted'],
      mediaUrls:
          (json['media_urls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      subcategory:
          json['subcategory'] != null
              ? Category.fromJson(json['subcategory'])
              : null,
      prices: json['prices'] != null ? Prices.fromJson(json['prices']) : null,
      averageRating: json['average_rating'],
      totalReviews: json['total_reviews'],
      qwikpick: json['qwikpick'],
      beautyAndEasy: json['beauty_and_easy'],
      isArabic: json['is_arabic'],
      hasOffers: json['has_offers'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'short_description': shortDescription,
    'image_url': imageUrl,
    'media_urls': mediaUrls,
    'category': category?.toJson(),
    'subcategory': subcategory?.toJson(),
    'prices': prices?.toJson(),
    'average_rating': averageRating,
    'total_reviews': totalReviews,
    'qwikpick': qwikpick,
    'beauty_and_easy': beautyAndEasy,
    'is_arabic': isArabic,
    'has_offers': hasOffers,
    'created_at': createdAt,
    'is_wishlisted': isWishlisted,
  };
}

class Category {
  int? id;
  String? name;
  String? imageUrl;

  Category({this.id, this.name, this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image_url': imageUrl,
  };
}

class Prices {
  String? onetime;
  String? weekly;
  String? monthly;
  String? yearly;

  Prices({this.onetime, this.weekly, this.monthly, this.yearly});

  factory Prices.fromJson(Map<String, dynamic> json) {
    return Prices(
      onetime: json['onetime'],
      weekly: json['weekly'],
      monthly: json['monthly'],
      yearly: json['yearly'],
    );
  }

  Map<String, dynamic> toJson() => {
    'onetime': onetime,
    'weekly': weekly,
    'monthly': monthly,
    'yearly': yearly,
  };
}

class Pagination {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;
  int? from;
  int? to;

  Pagination({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
    this.from,
    this.to,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
      from: json['from'],
      to: json['to'],
    );
  }

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'last_page': lastPage,
    'per_page': perPage,
    'total': total,
    'from': from,
    'to': to,
  };
}

class FiltersApplied {
  String? query;
  dynamic categoryId;
  dynamic subcategoryId;
  dynamic minPrice;
  dynamic maxPrice;
  String? sortBy;
  String? sortOrder;

  FiltersApplied({
    this.query,
    this.categoryId,
    this.subcategoryId,
    this.minPrice,
    this.maxPrice,
    this.sortBy,
    this.sortOrder,
  });

  factory FiltersApplied.fromJson(Map<String, dynamic> json) {
    return FiltersApplied(
      query: json['query'],
      categoryId: json['category_id'],
      subcategoryId: json['subcategory_id'],
      minPrice: json['min_price'],
      maxPrice: json['max_price'],
      sortBy: json['sort_by'],
      sortOrder: json['sort_order'],
    );
  }

  Map<String, dynamic> toJson() => {
    'query': query,
    'category_id': categoryId,
    'subcategory_id': subcategoryId,
    'min_price': minPrice,
    'max_price': maxPrice,
    'sort_by': sortBy,
    'sort_order': sortOrder,
  };
}
