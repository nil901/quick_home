
class BookingDate {
  final String date;
  final String day;
  final String formatted;

  BookingDate({
    required this.date,
    required this.day,
    required this.formatted,
  });

  factory BookingDate.fromJson(Map<String, dynamic> json) {
    return BookingDate(
      date: json['date'],
      day: json['day'],
      formatted: json['formatted'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'day': day,
        'formatted': formatted,
      };
}

class BookingTime {
  final String time;
  final String formatted;

  BookingTime({
    required this.time,
    required this.formatted,
  });

  factory BookingTime.fromJson(Map<String, dynamic> json) {
    return BookingTime(
      time: json['time'],
      formatted: json['formatted'],
    );
  }

  Map<String, dynamic> toJson() => {
        'time': time,
        'formatted': formatted,
      };
}

class ServiceProvider {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? image;
  final String averageRating;
  final String? lastServiceDate;
  final String? lastBookingStatus;
  final int totalServicesForCustomer;

  ServiceProvider({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.image,
    required this.averageRating,
    this.lastServiceDate,
    this.lastBookingStatus,
    required this.totalServicesForCustomer,
  });

  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
    return ServiceProvider(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      averageRating: json['average_rating'],
      lastServiceDate: json['last_service_date'],
      lastBookingStatus: json['last_booking_status'],
      totalServicesForCustomer: json['total_services_for_customer'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
        'average_rating': averageRating,
        'last_service_date': lastServiceDate,
        'last_booking_status': lastBookingStatus,
        'total_services_for_customer': totalServicesForCustomer,
      };
}
