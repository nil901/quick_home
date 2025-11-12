import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/model/address_model.dart';
import 'package:quick_home/model/wishlist_model.dart';
import 'package:quick_home/model/booking_options_model.dart';
import 'package:quick_home/model/cart_model.dart';
import 'package:quick_home/model/my_booking_model.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';

class cartServices {
  // ✅ Fetch My Bookings
  Future<void> mybookingAPi(WidgetRef ref, {required String type}) async {
    try {
      final data = {
        "user": AppPreference().getInt(PreferencesKey.userId),
        "type": type,
      };

      final response = await ApiService.postRequest(getMyBooking, data);
      if (response.data['success'] == true) {
        final dataList = response.data['data'] as List;
        ref.read(bookingHistoryProvider.notifier).state =
            dataList.map((json) => BookingHistoryModel.fromJson(json)).toList();
        print("✅ Booking history fetched successfully");
      } else {
        print("❌ Failed to fetch booking history: ${response.data['message']}");
      }
    } catch (e) {
      print("❌ Error fetching booking history: $e");
    }
  }

  // ✅ Fetch Address List
  Future<void> addressApi(WidgetRef ref) async {
    try {
      final userId = AppPreference().getInt(PreferencesKey.userId);
      final response = await ApiService.postRequest(addresses, {
        "user": userId,
      });

      if (response.data['success'] == true) {
        final data = response.data['data'] as List;
        ref.read(addressProvider.notifier).state =
            data.map((json) => Address.fromJson(json)).toList();
        print("✅ Address list updated (${data.length} addresses)");
      } else {
        print("❌ Failed to fetch addresses: ${response.data['message']}");
      }
    } catch (e) {
      print("❌ Error fetching addresses: $e");
    }
  }

  // ✅ Fetch Wishlist
  Future<void> wishlistApi(WidgetRef ref) async {
    try {
      final userId = AppPreference().getInt(PreferencesKey.userId);
      final response = await ApiService.postRequest(wishlist, {"user": userId});

      if (response.data['success'] == true) {
        final data = response.data['data'] as List;
        ref.read(wishlistProvider.notifier).state =
            data.map((json) => WishlistModel.fromJson(json)).toList();
        print("✅ Wishlist updated (${data.length} items)");
      } else {
        print("❌ Failed to fetch wishlist: ${response.data['message']}");
      }
    } catch (e) {
      print("❌ Error fetching wishlist: $e");
    }
  }

  // ✅ Fetch Cart Items
  Future<void> cartApi(WidgetRef ref) async {
    try {
      final userId = AppPreference().getInt(PreferencesKey.userId);
      final response = await ApiService.postRequest(getCart, {"user": userId});

      if (response.data['status'] == true) {
        final data = response.data['data']['cart_items'] as List;
        ref.read(cartProvider.notifier).state =
            data.map((json) => CartModel.fromJson(json)).toList();
        print("✅ Cart updated (${data.length} items)");
      } else {
        print("❌ Failed to fetch cart: ${response.data['message']}");
      }
    } catch (e) {
      print("❌ Error fetching cart: $e");
    }
  }

  // ✅ Fetch Booking Options (Main Fix)
  Future<void> bookingOptionsApi(
    WidgetRef ref, {
    int? serviceProviders,
    String? selectedDate,
  }) async {
    final selectedItem = ref.read(selectedCartProvider);

    try {
      final userId = AppPreference().getInt(PreferencesKey.userId);
      final serviceId = selectedItem?.service?.id;

      // 👇 Auto use current date if null
      final dateToSend =
          selectedDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now());

      print("📤 Sending Booking Options Request...");
      print({
        "user": userId,
        "service": serviceId,
        "serviceProvider": serviceProviders,
        "date": dateToSend,
      });

      final response = await ApiService.postRequest(getBookingOptions, {
        "user": userId,
        "service": serviceId,
        "serviceProvider": serviceProviders,
        "date": dateToSend,
      });

      if (response.data['success'] == true) {
        final jsonData = response.data['data'] ?? {};
        final dateList = (jsonData['dates'] ?? []) as List;
        final timeList = (jsonData['times'] ?? []) as List;
        final serviceList = (jsonData['service_providers'] ?? []) as List;

        // ✅ Update Riverpod Providers
        ref.read(bookingDateProvider.notifier).state =
            dateList.map((e) => BookingDate.fromJson(e)).toList();

        ref.read(bookingTimeProvider.notifier).state =
            timeList.map((e) => BookingTime.fromJson(e)).toList();

        ref.read(serviceProvider.notifier).state =
            serviceList.map((e) => ServiceProvider.fromJson(e)).toList();

        print("✅ Booking options updated successfully");
      } else {
        print("❌ Booking options failed: ${response.data['message']}");
      }
    } catch (e) {
      print("❌ Error fetching booking options: $e");
    }
  }
}
