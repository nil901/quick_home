class BookingHistoryModel{
  int? id;
  int? serviceId;
  int? customerId;
  int? serviceProviderId;
  int? vendorId;
  String? bookingReference;
  String? scheduledDate;
  String? preferredTime;
  String? startTime;
  String? endTime;
  String? status;
  String? paymentStatus;
  String? price;
  String? discountAmount;
  String? taxAmount;
  String? totalAmount;
  String? paidAmount;
  String? refundAmount;
  String? currency;
  String? paymentDueDate;
  String? bookingType;
  String? customerNotes;
  String? vendorNotes;
  String? cancellationReason;
  String? cancelledAt;
  String? cancellationFee;
  String? completedAt;
  String? createdAt;
  String? updatedAt;
  int? paymentMethodId;
  int? subscriptionId;
  int? parentBookingId;
  String? nextBookingDate;
  Service? service;
  dynamic serviceProvider;

  BookingHistoryModel({
    this.id,
    this.serviceId,
    this.customerId,
    this.serviceProviderId,
    this.vendorId,
    this.bookingReference,
    this.scheduledDate,
    this.preferredTime,
    this.startTime,
    this.endTime,
    this.status,
    this.paymentStatus,
    this.price,
    this.discountAmount,
    this.taxAmount,
    this.totalAmount,
    this.paidAmount,
    this.refundAmount,
    this.currency,
    this.paymentDueDate,
    this.bookingType,
    this.customerNotes,
    this.vendorNotes,
    this.cancellationReason,
    this.cancelledAt,
    this.cancellationFee,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
    this.paymentMethodId,
    this.subscriptionId,
    this.parentBookingId,
    this.nextBookingDate,
    this.service,
    this.serviceProvider,
  });

  factory BookingHistoryModel.fromJson(Map<String, dynamic> json) {
    return BookingHistoryModel(
      id: json['id'],
      serviceId: json['service_id'],
      customerId: json['customer_id'],
      serviceProviderId: json['service_provider_id'],
      vendorId: json['vendor_id'],
      bookingReference: json['booking_reference'],
      scheduledDate: json['scheduled_date'],
      preferredTime: json['preferred_time'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      status: json['status'],
      paymentStatus: json['payment_status'],
      price: json['price'],
      discountAmount: json['discount_amount'],
      taxAmount: json['tax_amount'],
      totalAmount: json['total_amount'],
      paidAmount: json['paid_amount'],
      refundAmount: json['refund_amount'],
      currency: json['currency'],
      paymentDueDate: json['payment_due_date'],
      bookingType: json['booking_type'],
      customerNotes: json['customer_notes'],
      vendorNotes: json['vendor_notes'],
      cancellationReason: json['cancellation_reason'],
      cancelledAt: json['cancelled_at'],
      cancellationFee: json['cancellation_fee'],
      completedAt: json['completed_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      paymentMethodId: json['payment_method_id'],
      subscriptionId: json['subscription_id'],
      parentBookingId: json['parent_booking_id'],
      nextBookingDate: json['next_booking_date'],
      service:
          json['service'] != null ? Service.fromJson(json['service']) : null,
      serviceProvider: json['service_provider'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_id': serviceId,
      'customer_id': customerId,
      'service_provider_id': serviceProviderId,
      'vendor_id': vendorId,
      'booking_reference': bookingReference,
      'scheduled_date': scheduledDate,
      'preferred_time': preferredTime,
      'start_time': startTime,
      'end_time': endTime,
      'status': status,
      'payment_status': paymentStatus,
      'price': price,
      'discount_amount': discountAmount,
      'tax_amount': taxAmount,
      'total_amount': totalAmount,
      'paid_amount': paidAmount,
      'refund_amount': refundAmount,
      'currency': currency,
      'payment_due_date': paymentDueDate,
      'booking_type': bookingType,
      'customer_notes': customerNotes,
      'vendor_notes': vendorNotes,
      'cancellation_reason': cancellationReason,
      'cancelled_at': cancelledAt,
      'cancellation_fee': cancellationFee,
      'completed_at': completedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'payment_method_id': paymentMethodId,
      'subscription_id': subscriptionId,
      'parent_booking_id': parentBookingId,
      'next_booking_date': nextBookingDate,
      'service': service?.toJson(),
      'service_provider': serviceProvider,
    };
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
  int? allowQuantityIncrement;
  String? createdAt;
  String? updatedAt;
  List<String>? media;
  bool? qwikpick;
  bool? beautyAndEasy;
  int? averageRating;
  int? totalReviews;
  String? imageUrl;
  List<String>? mediaUrls;

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
    this.allowQuantityIncrement,
    this.createdAt,
    this.updatedAt,
    this.media,
    this.qwikpick,
    this.beautyAndEasy,
    this.averageRating,
    this.totalReviews,
    this.imageUrl,
    this.mediaUrls,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      categoryId: json['category_id'],
      subcategoryId: json['subcategory_id'],
      name: json['name'],
      description: json['description'],
      whatsInclude:
          (json['whats_include'] as List?)?.map((e) => e.toString()).toList(),
      shortDescription: json['short_description'],
      priceOnetime: json['price_onetime'],
      priceOnetimeDescription: json['price_onetime_description'],
      durationOnetime: json['duration_onetime'],
      priceWeekly: json['price_weekly'],
      priceWeeklyDescription: json['price_weekly_description'],
      priceMonthly: json['price_monthly'],
      priceMonthlyDescription: json['price_monthly_description'],
      priceYearly: json['price_yearly'],
      priceYearlyDescription: json['price_yearly_description'],
      isArabic: json['is_arabic'],
      duration: json['duration'],
      status: json['status'],
      allowQuantityIncrement: json['allow_quantity_increment'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      media: (json['media'] as List?)?.map((e) => e.toString()).toList(),
      qwikpick: json['qwikpick'],
      beautyAndEasy: json['beauty_and_easy'],
      averageRating: json['average_rating'],
      totalReviews: json['total_reviews'],
      imageUrl: json['image_url'],
      mediaUrls:
          (json['media_urls'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'subcategory_id': subcategoryId,
      'name': name,
      'description': description,
      'whats_include': whatsInclude,
      'short_description': shortDescription,
      'price_onetime': priceOnetime,
      'price_onetime_description': priceOnetimeDescription,
      'duration_onetime': durationOnetime,
      'price_weekly': priceWeekly,
      'price_weekly_description': priceWeeklyDescription,
      'price_monthly': priceMonthly,
      'price_monthly_description': priceMonthlyDescription,
      'price_yearly': priceYearly,
      'price_yearly_description': priceYearlyDescription,
      'is_arabic': isArabic,
      'duration': duration,
      'status': status,
      'allow_quantity_increment': allowQuantityIncrement,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'media': media,
      'qwikpick': qwikpick,
      'beauty_and_easy': beautyAndEasy,
      'average_rating': averageRating,
      'total_reviews': totalReviews,
      'image_url': imageUrl,
      'media_urls': mediaUrls,
    };
  }
}
