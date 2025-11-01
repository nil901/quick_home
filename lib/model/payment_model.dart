class PaymentModel {
  int? userId;
  int? cartId;
  DefaultAddress? defaultAddress;
  List<String>? dateTime;
  int? serviceId;
  Service? service;
  List<Coupon>? coupons;
  CartDetails? cartDetails;
  PricingSummary? pricingSummary;
  RefundPolicy? refundPolicy;

  PaymentModel({
    this.userId,
    this.cartId,
    this.defaultAddress,
    this.dateTime,
    this.serviceId,
    this.service,
    this.coupons,
    this.cartDetails,
    this.pricingSummary,
    this.refundPolicy,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      userId: json['user_id'],
      cartId: json['cart_id'],
      defaultAddress:
          json['default_address'] != null
              ? DefaultAddress.fromJson(json['default_address'])
              : null,
      dateTime:
          (json['date_time'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
      serviceId: json['service_id'],
      service:
          json['service'] != null ? Service.fromJson(json['service']) : null,
      coupons:
          (json['coupons'] as List<dynamic>?)
              ?.map((e) => Coupon.fromJson(e))
              .toList(),
      cartDetails:
          json['cart_details'] != null
              ? CartDetails.fromJson(json['cart_details'])
              : null,
      pricingSummary:
          json['pricing_summary'] != null
              ? PricingSummary.fromJson(json['pricing_summary'])
              : null,
      refundPolicy:
          json['refund_policy'] != null
              ? RefundPolicy.fromJson(json['refund_policy'])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'cart_id': cartId,
    'default_address': defaultAddress?.toJson(),
    'date_time': dateTime,
    'service_id': serviceId,
    'service': service?.toJson(),
    'coupons': coupons?.map((e) => e.toJson()).toList(),
    'cart_details': cartDetails?.toJson(),
    'pricing_summary': pricingSummary?.toJson(),
    'refund_policy': refundPolicy?.toJson(),
  };

  copyWith({required pricingSummary}) {}
}

class DefaultAddress {
  int? id;
  int? userId;
  String? contactDetails;
  String? addressDetails;
  String? type;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;

  DefaultAddress({
    this.id,
    this.userId,
    this.contactDetails,
    this.addressDetails,
    this.type,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory DefaultAddress.fromJson(Map<String, dynamic> json) {
    return DefaultAddress(
      id: json['id'],
      userId: json['user_id'],
      contactDetails: json['contact_details'],
      addressDetails: json['address_details'],
      type: json['type'],
      isDefault: json['is_default'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
  };
}

class Service {
  int? id;
  String? name;
  String? description;
  String? image;

  Service({this.id, this.name, this.description, this.image});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'image': image,
  };
}

class Coupon {
  CouponCode? couponCode;

  Coupon({this.couponCode});

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      couponCode:
          json['coupon_code'] != null
              ? CouponCode.fromJson(json['coupon_code'])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {'coupon_code': couponCode?.toJson()};
}

class CouponCode {
  int? id;
  String? code;
  String? description;
  String? discountType;
  String? discountValue;
  String? expiryDate;
  dynamic usageLimit;
  int? usedCount;
  bool? status;
  String? applicableTo;
  dynamic serviceIds;
  String? createdAt;
  String? updatedAt;

  CouponCode({
    this.id,
    this.code,
    this.description,
    this.discountType,
    this.discountValue,
    this.expiryDate,
    this.usageLimit,
    this.usedCount,
    this.status,
    this.applicableTo,
    this.serviceIds,
    this.createdAt,
    this.updatedAt,
  });

  factory CouponCode.fromJson(Map<String, dynamic> json) {
    return CouponCode(
      id: json['id'],
      code: json['code'],
      description: json['description'],
      discountType: json['discount_type'],
      discountValue: json['discount_value'],
      expiryDate: json['expiry_date'],
      usageLimit: json['usage_limit'],
      usedCount: json['used_count'],
      status: json['status'],
      applicableTo: json['applicable_to'],
      serviceIds: json['service_ids'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'description': description,
    'discount_type': discountType,
    'discount_value': discountValue,
    'expiry_date': expiryDate,
    'usage_limit': usageLimit,
    'used_count': usedCount,
    'status': status,
    'applicable_to': applicableTo,
    'service_ids': serviceIds,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class CartDetails {
  int? id;
  num? total;
  int? totalItems;

  CartDetails({this.id, this.total, this.totalItems});

  factory CartDetails.fromJson(Map<String, dynamic> json) {
    return CartDetails(
      id: json['id'],
      total: json['total'],
      totalItems: json['total_items'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'total': total,
    'total_items': totalItems,
  };
}

class PricingSummary {
  num? subtotal;
  num? materialsTotal;
  num? discountAmount;
  num? taxAmount;
  num? totalAmount;
  int? totalItemsCount;
  String? currency;

  PricingSummary({
    this.subtotal,
    this.materialsTotal,
    this.discountAmount,
    this.taxAmount,
    this.totalAmount,
    this.totalItemsCount,
    this.currency,
  });

  factory PricingSummary.fromJson(Map<String, dynamic> json) {
    return PricingSummary(
      subtotal: json['subtotal'],
      materialsTotal: json['materials_total'],
      discountAmount: json['discount_amount'],
      taxAmount: json['tax_amount'],
      totalAmount: json['total_amount'],
      totalItemsCount: json['total_items_count'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() => {
    'subtotal': subtotal,
    'materials_total': materialsTotal,
    'discount_amount': discountAmount,
    'tax_amount': taxAmount,
    'total_amount': totalAmount,
    'total_items_count': totalItemsCount,
    'currency': currency,
  };

  copyWith({required String discountAmount, required String totalAmount}) {}
}

class RefundPolicy {
  int? id;
  String? title;
  String? content;
  String? createdAt;

  RefundPolicy({this.id, this.title, this.content, this.createdAt});

  factory RefundPolicy.fromJson(Map<String, dynamic> json) {
    return RefundPolicy(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'created_at': createdAt,
  };
}
