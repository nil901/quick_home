class NotifactionModel {
  final String? id;
  final String? type;
  final String? notifiableType;
  final int? notifiableId;
  final NotificationDetail? data;
  final String? readAt;
  final String? createdAt;
  final String? updatedAt;

  NotifactionModel({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  factory NotifactionModel.fromJson(Map<String, dynamic> json) {
    return NotifactionModel(
      id: json['id'],
      type: json['type'],
      notifiableType: json['notifiable_type'],
      notifiableId: json['notifiable_id'],
      data: json['data'] != null
              ? NotificationDetail.fromJson(json['data'])
              : null,
      readAt: json['read_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "notifiable_type": notifiableType,
    "notifiable_id": notifiableId,
    "data": data?.toJson(),
    "read_at": readAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class NotificationDetail {
  final String? title;
  final String? description;
  final String? bookingId;
  final String? type;
  final String? time;

  NotificationDetail({
    this.title,
    this.description,
    this.bookingId,
    this.type,
    this.time,
  });

  factory NotificationDetail.fromJson(Map<String, dynamic> json) {
    return NotificationDetail(
      title: json['title'],
      description: json['description'],
      bookingId: json['booking_id']?.toString(),
      type: json['type'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "booking_id": bookingId,
    "type": type,
    "time": time,
  };
}
