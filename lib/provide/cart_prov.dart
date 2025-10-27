import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/model/address_model.dart';
import 'package:quick_home/model/bannar_model.dart';
import 'package:quick_home/model/booking_options_model.dart';
import 'package:quick_home/model/cart_model.dart';
import 'package:quick_home/model/wishlist_model.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';

class cartServices {
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

  Future<void> bookingOptionsApi(WidgetRef ref) async {
    try {
      final response = await ApiService.postRequest(getBookingOptions, {
        "user": AppPreference().getInt(PreferencesKey.userId),
        "service": 49,
      });

      if (response.data['success'] == true) {
        final jsonData = response.data['data'];

        final data = jsonData['dates'] as List;
        final time = jsonData['times'] as List;
        final service = jsonData['service_providers'] as List;
        print("data is $data");
        ref.read(bookingDateProvider.notifier).state =
            data.map((json) => BookingDate.fromJson(json)).toList();

        ref.read(bookingTimeProvider.notifier).state =
            time.map((json) => BookingTime.fromJson(json)).toList();

        ref.read(serviceProvider.notifier).state =
            service.map((json) => ServiceProvider.fromJson(json)).toList();

      } else {
        print("API returned error: ${response.data['message']}");
      }
    } catch (e) {
      print("Error fetching booking options: $e");
      throw Exception("Failed to load booking options");
    }
  }
}
