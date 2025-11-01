import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/util/enum.dart';
import '../api_services/api_services.dart';
import '../prefs/app_preference.dart';
import '../prefs/preferences_keys.dart';
import '../screen/auth/login_screen.dart';

class AddressService {
  Future<bool> deleteAddress({
    required int userId,
    required int addressId,
  }) async {
    try {
      final response = await ApiService.postRequest('addresses-delete', {
        'user': userId,
        'address_id': addressId,
      });

      if (response.data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Delete address error: $e');
      return false;
    }
  }

  Future<void> logoutUser(BuildContext context, WidgetRef ref) async {
    try {
      // 👇 Get current logged-in user ID
      final userId = await AppPreference().getInt(PreferencesKey.userId);

      // 👇 Print user ID to console
      print("🔹 Logging out user with ID: $userId");

      if (userId == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("User not found!")));
        return;
      }

      // 👇 API Call
      final response = await ApiService.postRequest('logout', {
        'user': userId.toString(),
      });

      print("🔹 Logout API Response: ${response.data}");

      // 👇 Success check
      if (response.statusCode == 200 && response.data['success'] == true) {
        await AppPreference().clearSharedPreferences();

        ref.invalidate(bannarProvider);
        ref.invalidate(categoryProvider);
        ref.invalidate(serviceModelProvider);
        ref.invalidate(productProvider);
        ref.invalidate(addressProvider);
        ref.invalidate(offerProvider);
        ref.invalidate(wishlistProvider);
        ref.invalidate(cartProvider);
        ref.invalidate(selectedCartProvider);
        ref.invalidate(selectedPaymentProvider);
        ref.invalidate(serviceDetailsProvider);
        ref.invalidate(bookingDateProvider);
        ref.invalidate(bookingTimeProvider);
        ref.invalidate(serviceProvider);
        ref.invalidate(profileProvider);
        ref.invalidate(addressDeleteProvider);
        ref.invalidate(bookingHistoryProvider);
        ref.invalidate(searchProvider);
        ref.invalidate(notifactionProvider);
        // ref.container.invalidateAll();
         ref.read(bottomTabProvider.notifier).state = BottomTab.home;
        AppPreference().getString(PreferencesKey.name);

        AppPreference().getString(PreferencesKey.email);

        // 👇 Navigate to login screen and clear backstack
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );

        // 👇 Show confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.data['message'] ?? "Logout successful"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['message'] ?? "Logout failed")),
        );
      }
    } catch (e) {
      print("❌ Logout error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error during logout: $e")));
    }
  }

  Future<void> deleteAccount(BuildContext context, WidgetRef ref) async {
    try {
      final userId = await AppPreference().getInt(PreferencesKey.userId);

      print("🧑‍💻 Deleting account for user ID: $userId");

      if (userId == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("User not found!")));
        return;
      }

      // 👇 API Call
      final response = await ApiService.postRequest('delete-account', {
        'user': userId.toString(),
      });
      print('user id is :$userId');

      print("🧾 Delete Account API Response: ${response.data}");

      if (response.statusCode == 200 && response.data['success'] == true) {
        // 👇 Clear all saved preferences
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );

        await AppPreference().clearSharedPreferences();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.data['message'] ?? "Account deleted successfully",
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.data['message'] ?? "Failed to delete account",
            ),
          ),
        );
      }
    } catch (e) {
      print("❌ Delete account error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong while deleting account")),
      );
    }
  }
}
