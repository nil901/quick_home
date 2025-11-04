import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/model/address_model.dart';
import 'package:quick_home/model/bannar_model.dart';
import 'package:quick_home/model/booking_options_model.dart';
import 'package:quick_home/model/cart_model.dart';
import 'package:quick_home/model/my_booking_model.dart';
import 'package:quick_home/model/wishlist_model.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';
import 'package:dio/dio.dart';

class cartServices {
  Future<void> mybookingAPi(WidgetRef ref, {required String type}) async {
    try {
      final data = {"user": 18, "type": type};
      final response = await ApiService.postRequest(getMyBooking, data);
      if (response.data['success'] == true) {
        final data = response.data['data'] as List;

        ref.read(bookingHistoryProvider.notifier).state =
            data.map((json) => BookingHistoryModel.fromJson(json)).toList();
      } else {
        print("Failed to fetch booking history: ${response.data['message']}");
      }
    } catch (e) {
      print("Error fetching appointments: $e");
      throw Exception("Failed to load data");
    }
  }

  Future<void> addressApi(WidgetRef ref) async {
    // print("helowwckxckdnkdfn");
    try {
      final response = await ApiService.postRequest(addresses, {
        "user": AppPreference().getInt(PreferencesKey.userId),
      });
      print(response?.data['data']);
      if (response.data['success'] == true) {
        final data = response.data['data'] as List;

        print(data);

        ref.read(addressProvider.notifier).state =
            data.map((json) => Address.fromJson(json)).toList();
      } else {}
    } catch (e) {
      print("Error fetching appointments: $e");
      throw Exception("Failed to load data");
    }
  }

  Future<void> wishlistApi(WidgetRef ref) async {
    // print("helowwckxckdnkdfn");
    try {
      final response = await ApiService.postRequest(wishlist, {
        "user": AppPreference().getInt(PreferencesKey.userId),
      });
      print(response?.data['data']);
      if (response.data['success'] == true) {
        final data = response.data['data'] as List;

        print(data);

        ref.read(wishlistProvider.notifier).state =
            data.map((json) => WishlistModel.fromJson(json)).toList();
      } else {}
    } catch (e) {
      print("Error fetching appointments: $e");
      throw Exception("Failed to load data");
    }
  }

  Future<void> cartApi(WidgetRef ref) async {
    // print("helowwckxckdnkdfn");
    try {
      final response = await ApiService.postRequest(getCart, {
        "user": AppPreference().getInt(PreferencesKey.userId),
      });
      print(response?.data['data']);
      if (response.data['status'] == true) {
        final data = response.data['data']['cart_items'] as List;

        print(data);

        ref.read(cartProvider.notifier).state =
            data.map((json) => CartModel.fromJson(json)).toList();
      } else {}
    } catch (e) {
      print("Error fetching appointments: $e");
      throw Exception("Failed to load data");
    }
  }

  Future<void> bookingOptionsApi(
    WidgetRef ref, {
    serviceProviders,
    date,
  }) async {
    final selectedItem = ref.read(selectedCartProvider);

    try {
      final response = await ApiService.postRequest(getBookingOptions, {
        "user": AppPreference().getInt(PreferencesKey.userId),
        "service": selectedItem?.service?.id,
        "serviceProvider": serviceProviders,
        "date": date,
      });

      if (response.data['success'] == true) {
        final jsonData = response.data['data'];

        final dateList = jsonData['dates'] as List;
        final timeList = jsonData['times'] as List;
        final serviceList = jsonData['service_providers'] as List;

        // Update Riverpod States
        ref.read(bookingDateProvider.notifier).state =
            dateList.map((e) => BookingDate.fromJson(e)).toList();

        ref.read(bookingTimeProvider.notifier).state =
            timeList.map((e) => BookingTime.fromJson(e)).toList();

        ref.read(serviceProvider.notifier).state =
            serviceList.map((e) => ServiceProvider.fromJson(e)).toList();

        print("✅ Booking options updated successfully");
      } else {
        print("❌ API returned error: ${response.data['message']}");
      }
    } catch (e) {
      print("❌ Error fetching booking options: $e");
      throw Exception("Failed to load booking options");
    }
  }
}
