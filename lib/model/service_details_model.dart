class ServiceDetailsModel {
  bool? success;
  int? statusCode;
  String? message;
  ServiceData? data;

  ServiceDetailsModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) {
    return ServiceDetailsModel(
      success: json['success'],
      statusCode: json['status_code'],
      message: json['message'],
      data: json['data'] != null ? ServiceData.fromJson(json['data']) : null,
    );
  }
}

class ServiceData {
  Service? service;

  ServiceData({this.service});

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      service: json['service'] != null ? Service.fromJson(json['service']) : null,
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
  List<dynamic>? servicePersons;
  Prices? prices;

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
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      categoryId: json['category_id'],
      subcategoryId: json['subcategory_id'],
      name: json['name'],
      description: json['description'],
      whatsInclude: json['whats_include'] != null
          ? List<String>.from(json['whats_include'])
          : [],
      shortDescription: json['short_description'],
      isArabic: json['is_arabic'],
      duration: json['duration'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      media: json['media'] != null ? List<String>.from(json['media']) : [],
      qwikpick: json['qwikpick'],
      beautyAndEasy: json['beauty_and_easy'],
      averageRating: (json['average_rating'] ?? 0).toDouble(),
      totalReviews: json['total_reviews'] ?? 0,
      imageUrl: json['image_url'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      subcategory: json['subcategory'] != null
          ? Subcategory.fromJson(json['subcategory'])
          : null,
      requirements: json['requirements'] != null
          ? List<Requirement>.from(
              json['requirements'].map((x) => Requirement.fromJson(x)))
          : [],
      processes: json['processes'] != null
          ? List<Process>.from(
              json['processes'].map((x) => Process.fromJson(x)))
          : [],
      faq: json['faq'] != null
          ? Map.from(json['faq'])
              .map((k, v) => MapEntry(k, FAQItem.fromJson(v)))
          : {},
      subscriptionPlans: json['subscription_plans'] != null
          ? List<SubscriptionPlan>.from(json['subscription_plans']
              .map((x) => SubscriptionPlan.fromJson(x)))
          : [],
      materials: json['materials'] != null
          ? List<MaterialItem>.from(
              json['materials'].map((x) => MaterialItem.fromJson(x)))
          : [],
      servicePersons: json['service_persons'] ?? [],
      prices:
          json['prices'] != null ? Prices.fromJson(json['prices']) : null,
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
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      image: json['image'],
      imageUrl: json['image_url'],
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
      id: json['id'],
      serviceId: json['service_id'],
      title: json['title'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      imageUrl: json['image_url'],
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
      id: json['id'],
      serviceId: json['service_id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      order: json['order'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      imageUrl: json['image_url'],
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
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      status: json['status'],
      serviceId: json['service_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
      id: json['id'],
      serviceId: json['service_id'],
      frequencyType: json['frequency_type'],
      noOfTimes: json['no_of_times'],
      duration: json['duration'],
      pricePerTime: json['price_per_time'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
      id: json['id'],
      serviceId: json['service_id'],
      materialName: json['material_name'],
      materialDescription: json['material_description'],
      applicableTo: json['applicable_to'],
      materialPrice: json['material_price'],
      materialImage: json['material_image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
      priceOnetime: json['price_onetime'],
      priceOnetimeDescription: json['price_onetime_description'],
      durationOnetime: json['duration_onetime'],
      priceWeekly: json['price_weekly'],
      priceWeeklyDescription: json['price_weekly_description'],
      priceMonthly: json['price_monthly'],
      priceMonthlyDescription: json['price_monthly_description'],
      priceYearly: json['price_yearly'],
      priceYearlyDescription: json['price_yearly_description'],
    );
  }
}
