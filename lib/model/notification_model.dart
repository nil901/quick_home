class NotificationModel {
  bool? status;
  int? statusCode;
  String? message;
  NotificationData? data;

  NotificationModel({this.status, this.statusCode, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data =
        json['data'] != null ? NotificationData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NotificationData {
  List<NotificationItem>? notifications;

  NotificationData({this.notifications});

  NotificationData.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <NotificationItem>[];
      json['notifications'].forEach((v) {
        notifications!.add(NotificationItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationItem {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  NotificationDetail? data;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  NotificationItem({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  NotificationItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    data =
        json['data'] != null ? NotificationDetail.fromJson(json['data']) : null;
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['type'] = type;
    data['notifiable_type'] = notifiableType;
    data['notifiable_id'] = notifiableId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['read_at'] = readAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class NotificationDetail {
  String? title;
  String? description;
  String? bookingId;
  String? type;
  String? time;

  NotificationDetail({
    this.title,
    this.description,
    this.bookingId,
    this.type,
    this.time,
  });

  NotificationDetail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    bookingId = json['booking_id']?.toString();
    type = json['type'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    data['booking_id'] = bookingId;
    data['type'] = type;
    data['time'] = time;
    return data;
  }
}
