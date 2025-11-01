class ServiceDetailsModel {
  bool? success;
  int? statusCode;
  String? message;
  ServiceData? data;

  ServiceDetailsModel({this.success, this.statusCode, this.message, this.data});

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) {
    return ServiceDetailsModel(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null ? ServiceData.fromJson(json['data']) : null,
    );
  }

  ServiceDetailsModel copyWith({
    bool? success,
    int? statusCode,
    String? message,
    ServiceData? data,
  }) {
    return ServiceDetailsModel(
      success: success ?? this.success,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

class ServiceData {
  Service? service;
  int? inCartQuantity;
  int? allowIncrement;

  ServiceData({this.service, this.inCartQuantity, this.allowIncrement});

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      service:
          json['service'] != null ? Service.fromJson(json['service']) : null,
      inCartQuantity: json['in_cart_quantity'] as int?,
      allowIncrement: json['allow_increment'] as int?,
    );
  }

  ServiceData copyWith({
    Service? service,
    int? inCartQuantity,
    int? allowIncrement,
  }) {
    return ServiceData(
      service: service ?? this.service,
      inCartQuantity: inCartQuantity ?? this.inCartQuantity,
      allowIncrement: allowIncrement ?? this.allowIncrement,
    );
  }
}

class Service {
  int? id;
  int? categoryId;
  int? subcategoryId;
  String? name;
  String? description;
  List<String>? whatsInclude;
  String? shortDescription;
  bool? isArabic;
  String? duration;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<String>? media;
  bool? qwikpick;
  bool? beautyAndEasy;
  double? averageRating;
  int? totalReviews;
  String? imageUrl;
  Category? category;
  Subcategory? subcategory;
  List<Requirement>? requirements;
  List<Process>? processes;
  Map<String, FAQItem>? faq;
  List<SubscriptionPlan>? subscriptionPlans;
  List<MaterialItem>? materials;
  List<ServicePerson>? servicePersons;
  Prices? prices;
  int? withMaterialPrice;
  int? withoutMaterialPrice;
  bool? isWishlisted;
  String? onetimePrice;

  Service({
    this.id,
    this.categoryId,
    this.subcategoryId,
    this.name,
    this.description,
    this.whatsInclude,
    this.shortDescription,
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
    this.category,
    this.subcategory,
    this.requirements,
    this.processes,
    this.faq,
    this.subscriptionPlans,
    this.materials,
    this.servicePersons,
    this.prices,
    this.withMaterialPrice,
    this.withoutMaterialPrice,
    this.isWishlisted,
    this.onetimePrice,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as int?,
      categoryId: json['category_id'] as int?,
      subcategoryId: json['subcategory_id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      whatsInclude:
          json['whats_include'] != null
              ? List<String>.from(json['whats_include'])
              : [],
      shortDescription: json['short_description'] as String?,
      isArabic: json['is_arabic'] as bool?,
      duration: json['duration'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      media: json['media'] != null ? List<String>.from(json['media']) : [],
      qwikpick: json['qwikpick'] as bool?,
      beautyAndEasy: json['beauty_and_easy'] as bool?,
      averageRating: (json['average_rating'] ?? 0).toDouble(),
      totalReviews: json['total_reviews'] ?? 0,
      imageUrl: json['image_url'] as String?,
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      subcategory:
          json['subcategory'] != null
              ? Subcategory.fromJson(json['subcategory'])
              : null,
      requirements:
          json['requirements'] != null
              ? List<Requirement>.from(
                json['requirements'].map((x) => Requirement.fromJson(x)),
              )
              : [],
      processes:
          json['processes'] != null
              ? List<Process>.from(
                json['processes'].map((x) => Process.fromJson(x)),
              )
              : [],
      faq:
          json['faq'] != null
              ? (json['faq'] as Map<String, dynamic>).map(
                (key, value) => MapEntry(
                  key,
                  FAQItem.fromJson(value as Map<String, dynamic>),
                ),
              )
              : {},
      subscriptionPlans:
          json['subscription_plans'] != null
              ? List<SubscriptionPlan>.from(
                json['subscription_plans'].map(
                  (x) => SubscriptionPlan.fromJson(x),
                ),
              )
              : [],
      materials:
          json['materials'] != null
              ? List<MaterialItem>.from(
                json['materials'].map((x) => MaterialItem.fromJson(x)),
              )
              : [],
      servicePersons:
          json['service_persons'] != null
              ? List<ServicePerson>.from(
                json['service_persons'].map((x) => ServicePerson.fromJson(x)),
              )
              : [],
      prices: json['prices'] != null ? Prices.fromJson(json['prices']) : null,
      withMaterialPrice: json['withMaterialPrice'] as int?,
      withoutMaterialPrice: json['withoutMaterialPrice'] as int?,
      isWishlisted: json['is_wishlisted'] as bool?,
      onetimePrice: json['onetime_price'] as String?,
    );
  }
}

class Category {
  int? id;
  String? name;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? imageUrl;

  Category({
    this.id,
    this.name,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      image: json['image'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }
}

class Subcategory {
  int? id;
  int? categoryId;
  String? name;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? imageUrl;

  Subcategory({
    this.id,
    this.categoryId,
    this.name,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.imageUrl,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['id'] as int?,
      categoryId: json['category_id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      image: json['image'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }
}

class Requirement {
  int? id;
  int? serviceId;
  String? title;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  Requirement({
    this.id,
    this.serviceId,
    this.title,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory Requirement.fromJson(Map<String, dynamic> json) {
    return Requirement(
      id: json['id'] as int?,
      serviceId: json['service_id'] as int?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }
}

class Process {
  int? id;
  int? serviceId;
  String? title;
  String? description;
  String? image;
  int? order;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  Process({
    this.id,
    this.serviceId,
    this.title,
    this.description,
    this.image,
    this.order,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory Process.fromJson(Map<String, dynamic> json) {
    return Process(
      id: json['id'] as int?,
      serviceId: json['service_id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      order: json['order'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }
}

class FAQItem {
  int? id;
  String? question;
  String? answer;
  int? status;
  int? serviceId;
  String? createdAt;
  String? updatedAt;

  FAQItem({
    this.id,
    this.question,
    this.answer,
    this.status,
    this.serviceId,
    this.createdAt,
    this.updatedAt,
  });

  factory FAQItem.fromJson(Map<String, dynamic> json) {
    return FAQItem(
      id: json['id'] as int?,
      question: json['question'] as String?,
      answer: json['answer'] as String?,
      status: json['status'] as int?,
      serviceId: json['service_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

class SubscriptionPlan {
  int? id;
  int? serviceId;
  String? frequencyType;
  int? noOfTimes;
  int? duration;
  String? pricePerTime;
  String? description;
  String? createdAt;
  String? updatedAt;

  SubscriptionPlan({
    this.id,
    this.serviceId,
    this.frequencyType,
    this.noOfTimes,
    this.duration,
    this.pricePerTime,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'] as int?,
      serviceId: json['service_id'] as int?,
      frequencyType: json['frequency_type'] as String?,
      noOfTimes: json['no_of_times'] as int?,
      duration: json['duration'] as int?,
      pricePerTime: json['price_per_time'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

class MaterialItem {
  int? id;
  int? serviceId;
  String? materialName;
  String? materialDescription;
  String? applicableTo;
  String? materialPrice;
  String? materialImage;
  String? createdAt;
  String? updatedAt;

  MaterialItem({
    this.id,
    this.serviceId,
    this.materialName,
    this.materialDescription,
    this.applicableTo,
    this.materialPrice,
    this.materialImage,
    this.createdAt,
    this.updatedAt,
  });

  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      id: json['id'] as int?,
      serviceId: json['service_id'] as int?,
      materialName: json['withMaterialPrice'] as String?,
      materialDescription: json['material_description'] as String?,
      applicableTo: json['applicable_to'] as String?,
      materialPrice: json['material_price'] as String?,
      materialImage: json['material_image'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

class ServicePerson {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? role;
  String? address;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  ServicePerson({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory ServicePerson.fromJson(Map<String, dynamic> json) {
    return ServicePerson(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      address: json['address'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }
}

class Prices {
  String? priceOnetime;
  String? priceOnetimeDescription;
  String? durationOnetime;
  String? priceWeekly;
  String? priceWeeklyDescription;
  String? priceMonthly;
  String? priceMonthlyDescription;
  String? priceYearly;
  String? priceYearlyDescription;

  Prices({
    this.priceOnetime,
    this.priceOnetimeDescription,
    this.durationOnetime,
    this.priceWeekly,
    this.priceWeeklyDescription,
    this.priceMonthly,
    this.priceMonthlyDescription,
    this.priceYearly,
    this.priceYearlyDescription,
  });

  factory Prices.fromJson(Map<String, dynamic> json) {
    return Prices(
      priceOnetime: json['price_onetime'] as String?,
      priceOnetimeDescription: json['price_onetime_description'] as String?,
      durationOnetime: json['duration_onetime'] as String?,
      priceWeekly: json['price_weekly'] as String?,
      priceWeeklyDescription: json['price_weekly_description'] as String?,
      priceMonthly: json['price_monthly'] as String?,
      priceMonthlyDescription: json['price_monthly_description'] as String?,
      priceYearly: json['price_yearly'] as String?,
      priceYearlyDescription: json['price_yearly_description'] as String?,
    );
  }
}
