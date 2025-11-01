import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/screen/auth/login_screen.dart';
import 'package:quick_home/util/enum.dart';
import '../api_services/api_services.dart';
import '../prefs/app_preference.dart';
import '../prefs/preferences_keys.dart';

final addAddressProvider =
    StateNotifierProvider<AddAddressNotifier, AsyncValue<String>>(
      (ref) => AddAddressNotifier(),
    );

class AddAddressNotifier extends StateNotifier<AsyncValue<String>> {
  AddAddressNotifier() : super(const AsyncData(''));

  Future<void> addAddress({
    required String contactDetails,
    required String addressDetails,
    required String type,
    required int isDefault,
  }) async {
    state = const AsyncLoading();
    try {
      // Get userId from preferences
      final userId = AppPreference().getInt(PreferencesKey.userId);

      final data = {
        'user': userId,
        'contact_details': contactDetails,
        'address_details': addressDetails,
        'type': type,
        'is_default': isDefault,
      };

      final response = await ApiService.postRequest(
        'addresses-store', // endpoint
        data,
      );

      if (response.data['success'] == true) {
        state = AsyncData(
          response.data['message'] ?? 'Address added successfully',
        );
      } else {
        // state = AsyncError(response.data['message'] ?? 'Failed to add address')
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> logoutUser(BuildContext context, WidgetRef ref) async {
    try {
      // 👇 Get current logged-in user ID
      final userId = await AppPreference().getInt(PreferencesKey.userId);

      // 👇 Print user ID to console
      print("🔹 Logging out user with ID: $userId");


      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not found!")),
        );
        return;
      }

      // 👇 API Call
      final response = await ApiService.postRequest(
        'logout',
        {'user': userId.toString()},
      );


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

  // 3️⃣ Reset bottom tab to Home
   
        AppPreference().getString(
          PreferencesKey.name,

        );

        AppPreference().getString(
          PreferencesKey.email,

        );

        // 👇 Navigate to login screen and clear backstack
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
        );

        // 👇 Show confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['message'] ?? "Logout successful")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['message'] ?? "Logout failed")),
        );
      }
    } catch (e) {
      print("❌ Logout error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during logout: $e")),
      );
    }
  }

  Future<void> deleteAccount(BuildContext context, WidgetRef ref) async {
    try {

      final userId = await AppPreference().getInt(PreferencesKey.userId);

      print("🧑‍💻 Deleting account for user ID: $userId");

      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not found!")),
        );
        return;
      }

      // 👇 API Call
      final response = await ApiService.postRequest(
        'delete-account',
        {'user': userId.toString()},
      );
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
            content: Text(response.data['message'] ?? "Account deleted successfully"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.data['message'] ?? "Failed to delete account"),
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


final editAddressProvider =
StateNotifierProvider<EditAddressNotifier, AsyncValue<String>>(
      (ref) => EditAddressNotifier(),
);
class EditAddressNotifier extends StateNotifier<AsyncValue<String>> {
  EditAddressNotifier() : super(const AsyncData(''));

  Future<void> editAddress({
    required int addressId,
    required String contactDetails,
    required String addressDetails,
    required String type,
    required int isDefault,
  }) async {
    state = const AsyncLoading();

    try {
      final userId = AppPreference().getInt(PreferencesKey.userId);
      final data = {
        "user": userId,
        "address_id": addressId,
        "contact_details": contactDetails,
        "address_details": addressDetails,
        "type": type,
        "is_default": isDefault,
      };
      print('EDIT DATA: $data');
      final res = await ApiService.postRequest('addresses-edit', data);

      if (res.data['success'] == true) {
        state = AsyncData(
          res.data['message'] ?? "Address updated successfully",
        );
      } else {
        // state = AsyncError(res.data['message'] ?? "Failed to update address");
      }
    } catch (e) {
      // state = AsyncError(e.toString());
    }
  }
}

