import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/Logic/API/provider.dart';
import 'package:quick_home/Logic/API/api_services.dart';
import 'package:quick_home/Logic/Model/profile_model.dart';
import 'package:quick_home/Logic/prefs/app_prefs.dart';
import 'package:quick_home/Logic/prefs/preference_key.dart';
import 'package:quick_home/Logic/url/url.dart';
import 'package:quick_home/screen/dashboard/mid_screens/sub_categories_screen.dart';

class HomeServices {
  Future<void> profileApi(WidgetRef ref) async {
    try {
      final response = await ApiService.postRequest(getProfile, {
        // Changed from ApiService.postRequest to ApiService.postRequest
        "user": AppPreference().getInt(PreferencesKey.userId),
      });

      if (response.data['success'] == true) {
        final userJson = response.data['user'];
        final profile = ProfileModel.fromJson(userJson);

        ref.read(profileProvider.notifier).state = profile;
      }
    } catch (e) {
      print("Error fetching profile: $e");
      throw Exception("Failed to load profile data");
    }
  }
}
