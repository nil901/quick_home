class SubscriptionResponseModel {

  final SubscriptionData? data;

  SubscriptionResponseModel({


    this.data,
  });

  factory SubscriptionResponseModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponseModel(
      data: json['data'] != null ? SubscriptionData.fromJson(json['data']) : null,
    );
  }
}

class SubscriptionData {
  final List<Subscription> subscriptions;
  final int totalCount;
  final int activeCount;
  final int pausedCount;
  final int cancelledCount;
  final List<ExplorePlan> exploreOtherPlans;

  SubscriptionData({
    required this.subscriptions,
    required this.totalCount,
    required this.activeCount,
    required this.pausedCount,
    required this.cancelledCount,
    required this.exploreOtherPlans,
  });

  factory SubscriptionData.fromJson(Map<String, dynamic> json) {
    return SubscriptionData(
      subscriptions: (json['subscriptions'] as List<dynamic>?)
              ?.map((e) => Subscription.fromJson(e))
              .toList() ??
          [],
      totalCount: json['total_count'] ?? 0,
      activeCount: json['active_count'] ?? 0,
      pausedCount: json['paused_count'] ?? 0,
      cancelledCount: json['cancelled_count'] ?? 0,
      exploreOtherPlans: (json['explore_other_plans'] as List<dynamic>?)
              ?.map((e) => ExplorePlan.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Subscription {
  final int id;
  final String subscriptionNumber;
  final String status;
  final String? startDate;
  final String? endDate;
  final String? nextBillingDate;
  final String billingCycle;
  final int billingDay;
  final String basePrice;
  final String totalAmount;
  final bool autoRenew;
  final int failedPaymentCount;
  final String? lastPaymentDate;
  final String lastPaymentAmount;
  final bool canBeCancelled;
  final bool canBePaused;
  final bool canBeResumed;
  final double daysUntilNextBilling;
  final Service? service;
  final SubscriptionPlan? subscriptionPlan;
  final dynamic paymentMethod;
  final List<dynamic> recentBookings;
  final List<dynamic> paymentHistory;
  final List<dynamic> billingCycles;

  Subscription({
    required this.id,
    required this.subscriptionNumber,
    required this.status,
    this.startDate,
    this.endDate,
    this.nextBillingDate,
    required this.billingCycle,
    required this.billingDay,
    required this.basePrice,
    required this.totalAmount,
    required this.autoRenew,
    required this.failedPaymentCount,
    this.lastPaymentDate,
    required this.lastPaymentAmount,
    required this.canBeCancelled,
    required this.canBePaused,
    required this.canBeResumed,
    required this.daysUntilNextBilling,
    this.service,
    this.subscriptionPlan,
    this.paymentMethod,
    required this.recentBookings,
    required this.paymentHistory,
    required this.billingCycles,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'] ?? 0,
      subscriptionNumber: json['subscription_number'] ?? '',
      status: json['status'] ?? '',
      startDate: json['start_date'],
      endDate: json['end_date'],
      nextBillingDate: json['next_billing_date'],
      billingCycle: json['billing_cycle'] ?? '',
      billingDay: json['billing_day'] ?? 0,
      basePrice: json['base_price'] ?? '0.00',
      totalAmount: json['total_amount'] ?? '0.00',
      autoRenew: json['auto_renew'] ?? false,
      failedPaymentCount: json['failed_payment_count'] ?? 0,
      lastPaymentDate: json['last_payment_date'],
      lastPaymentAmount: json['last_payment_amount'] ?? '0.00',
      canBeCancelled: json['can_be_cancelled'] ?? false,
      canBePaused: json['can_be_paused'] ?? false,
      canBeResumed: json['can_be_resumed'] ?? false,
      daysUntilNextBilling:
          (json['days_until_next_billing'] ?? 0).toDouble(),
      service: json['service'] != null
          ? Service.fromJson(json['service'])
          : null,
      subscriptionPlan: json['subscription_plan'] != null
          ? SubscriptionPlan.fromJson(json['subscription_plan'])
          : null,
      paymentMethod: json['payment_method'],
      recentBookings: json['recent_bookings'] ?? [],
      paymentHistory: json['payment_history'] ?? [],
      billingCycles: json['billing_cycles'] ?? [],
    );
  }
}

class Service {
  final int id;
  final String name;
  final String description;
  final int categoryId;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['category_id'] ?? 0,
    );
  }
}

class SubscriptionPlan {
  final int id;
  final String frequencyType;
  final String pricePerTime;
  final int noOfTimes;
  final int duration;
  final String? description;

  SubscriptionPlan({
    required this.id,
    required this.frequencyType,
    required this.pricePerTime,
    required this.noOfTimes,
    required this.duration,
    this.description,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'] ?? 0,
      frequencyType: json['frequency_type'] ?? '',
      pricePerTime: json['price_per_time'] ?? '0.00',
      noOfTimes: json['no_of_times'] ?? 0,
      duration: json['duration'] ?? 0,
      description: json['description'],
    );
  }
}

class ExplorePlan {
  final int id;
  final String frequencyType;
  final String pricePerTime;
  final int noOfTimes;
  final int duration;
  final String? description;
  final Service? service;

  ExplorePlan({
    required this.id,
    required this.frequencyType,
    required this.pricePerTime,
    required this.noOfTimes,
    required this.duration,
    this.description,
    this.service,
  });

  factory ExplorePlan.fromJson(Map<String, dynamic> json) {
    return ExplorePlan(
      id: json['id'] ?? 0,
      frequencyType: json['frequency_type'] ?? '',
      pricePerTime: json['price_per_time'] ?? '0.00',
      noOfTimes: json['no_of_times'] ?? 0,
      duration: json['duration'] ?? 0,
      description: json['description'],
      service:
          json['service'] != null ? Service.fromJson(json['service']) : null,
    );
  }
}
