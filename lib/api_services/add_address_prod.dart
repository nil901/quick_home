import 'package:flutter_riverpod/flutter_riverpod.dart';
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
