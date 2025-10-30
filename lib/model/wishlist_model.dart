import 'dart:convert';

class WishlistModel {
  Wishlist? wishlist;
  Service? service;
  Offer? offer;

  WishlistModel({this.wishlist, this.service, this.offer});

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
    wishlist:
        json["wishlist"] == null ? null : Wishlist.fromJson(json["wishlist"]),
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
  );

  Map<String, dynamic> toJson() => {
    "wishlist": wishlist?.toJson(),
    "service": service?.toJson(),
    "offer": offer?.toJson(),
  };
}

class Wishlist {
  dynamic id;
  dynamic userId;
  dynamic serviceId;
  dynamic offerId;
  String? createdAt;
  String? updatedAt;
  Service? service;
  Offer? offer;

  Wishlist({
    this.id,
    this.userId,
    this.serviceId,
    this.offerId,
    this.createdAt,
    this.updatedAt,
    this.service,
    this.offer,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
    id: json["id"],
    userId: json["user_id"],
    serviceId: json["service_id"],
    offerId: json["offer_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "service_id": serviceId,
    "offer_id": offerId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "service": service?.toJson(),
    "offer": offer?.toJson(),
  };
}

class Service {
  dynamic id;
  dynamic categoryId;
  dynamic subcategoryId;
  String? name;
  String? description;
  List<String>? whatsInclude;
  String? shortDescription;
  String? priceOnetime;
  String? priceOnetimeDescription;
  String? durationOnetime;
  String? priceWeekly;
  String? priceWeeklyDescription;
  String? priceMonthly;
  String? priceMonthlyDescription;
  String? priceYearly;
  String? priceYearlyDescription;
  bool? isArabic;
  String? duration;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? media;
  bool? qwikpick;
  bool? beautyAndEasy;
  double? averageRating;
  dynamic totalReviews;
  String? imageUrl;

  Service({
    this.id,
    this.categoryId,
    this.subcategoryId,
    this.name,
    this.description,
    this.whatsInclude,
    this.shortDescription,
    this.priceOnetime,
    this.priceOnetimeDescription,
    this.durationOnetime,
    this.priceWeekly,
    this.priceWeeklyDescription,
    this.priceMonthly,
    this.priceMonthlyDescription,
    this.priceYearly,
    this.priceYearlyDescription,
    this.isArabic,
    this.duration,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.media,
    this.qwikpick,
    this.beautyAndEasy,
    this.averageRating,
    this.totalReviews,
    this.imageUrl,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    // Handle image_url type safety (can be String or List)
    String? resolvedImage;
    if (json["image_url"] is List) {
      final list = json["image_url"] as List;
      resolvedImage = list.isNotEmpty ? list.first.toString() : null;
    } else if (json["image_url"] is String) {
      resolvedImage = json["image_url"];
    }

    return Service(
      id: json["id"],
      categoryId: json["category_id"],
      subcategoryId: json["subcategory_id"],
      name: json["name"],
      description: json["description"],
      whatsInclude:
          json["whats_include"] == null
              ? []
              : List<String>.from(
                json["whats_include"].map((x) => x.toString()),
              ),
      shortDescription: json["short_description"],
      priceOnetime: json["price_onetime"],
      priceOnetimeDescription: json["price_onetime_description"],
      durationOnetime: json["duration_onetime"],
      priceWeekly: json["price_weekly"],
      priceWeeklyDescription: json["price_weekly_description"],
      priceMonthly: json["price_monthly"],
      priceMonthlyDescription: json["price_monthly_description"],
      priceYearly: json["price_yearly"],
      priceYearlyDescription: json["price_yearly_description"],
      isArabic: json["is_arabic"],
      duration: json["duration"],
      status: json["status"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      media: json["media"],
      qwikpick: json["qwikpick"],
      beautyAndEasy: json["beauty_and_easy"],
      totalReviews: json["total_reviews"],
      averageRating: (json["average_rating"] ?? 0).toDouble(),
      imageUrl: resolvedImage,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "name": name,
    "description": description,
    "whats_include":
        whatsInclude == null
            ? []
            : List<dynamic>.from(whatsInclude!.map((x) => x)),
    "short_description": shortDescription,
    "price_onetime": priceOnetime,
    "price_onetime_description": priceOnetimeDescription,
    "duration_onetime": durationOnetime,
    "price_weekly": priceWeekly,
    "price_weekly_description": priceWeeklyDescription,
    "price_monthly": priceMonthly,
    "price_monthly_description": priceMonthlyDescription,
    "price_yearly": priceYearly,
    "price_yearly_description": priceYearlyDescription,
    "is_arabic": isArabic,
    "duration": duration,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "media": media,
    "qwikpick": qwikpick,
    "beauty_and_easy": beautyAndEasy,
    "average_rating": averageRating,
    "total_reviews": totalReviews,
    "image_url": imageUrl,
  };
}

class Offer {
  Offer();

  factory Offer.fromJson(Map<String, dynamic> json) => Offer();

  Map<String, dynamic> toJson() => {};
}
