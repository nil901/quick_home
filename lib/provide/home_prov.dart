import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/model/bannar_model.dart';
import 'package:quick_home/model/category_model.dart';
import 'package:quick_home/model/home_model.dart';
import 'package:quick_home/model/offers_model.dart';
import 'package:quick_home/model/profile_model.dart';
import 'package:quick_home/model/serviceModel.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';
import 'package:quick_home/screen/dashboard/mid_screens/sub_categories_screen.dart';

class HomeServices {
  Future<void> bannarApi(WidgetRef ref) async {
    // print("helowwckxckdnkdfn");
    try {
      final response = await ApiService.getRequest(banners);
      print(response?.data['data']);
      if (response.data['success'] == true) {
        final data = response.data['data']['banners'] as List;

        print(data);

        ref.read(bannarProvider.notifier).state =
            data.map((json) => BannerModel.fromJson(json)).toList();
      } else {}
    } catch (e) {
      print("Error fetching appointments: $e");
      throw Exception("Failed to load data");
    }
  }

  Future<void> categoryApi(WidgetRef ref) async {
    // print("helowwckxckdnkdfn");
    try {
      final response = await ApiService.getRequest(categories);
      print(response?.data['data']);
      if (response.data['success'] == true) {
        final data = response.data['data']['categories'] as List;

        print(data);

        ref.read(categoryProvider.notifier).state =
            data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {}
    } catch (e) {
      print("Error fetching appointments: $e");
      throw Exception("Failed to load data");
    }
  }

  Future<void> subCategoriesApi(WidgetRef ref, catId) async {
    // print("helowwckxckdnkdfn");
    try {
      final response = await ApiService.postRequest(services, {
        "category": catId,
        // "subcategory"
      });
      print(response?.data['data']);
      if (response.data['success'] == true) {
        final data = response.data['data']['services'] as List;

        print(data);
        SubcategoreyProductApi(ref, data[0]['subcategory_id']);
        ref.read(serviceModelProvider.notifier).state =
            data.map((json) => ServicesModel.fromJson(json)).toList();
      } else {}
    } catch (e) {
      print("Error fetching appointments: $e");
      throw Exception("Failed to load data");
    }
  }

  Future<void> offerApi(WidgetRef ref) async {
    try {
      final response = await ApiService.getRequest(offers);

      if (response.data['success'] == true) {
        final data = response.data['data']; // contains "sections"

        // parse the whole response into HomeModel
        final homeModel = HomeModel.fromJson(data);

        ref.read(offerProvider.notifier).state = [homeModel];
      }
    } catch (e) {
      print("Error fetching offers: $e");
      throw Exception("Failed to load data");
    }
  }

  Future<void> SubcategoreyProductApi(WidgetRef ref, subCategory) async {
    // print("helowwckxckdnkdfn");
    try {
      final response = await ApiService.postRequest(servicesOfSubcategory, {
        "subcategory": subCategory,
        // "subcategory"
      });
      print("ssssssssssssssssssssssssssssssssss${subCategory}");
      //  print(response?.data['data']);
      if (response.data['success'] == true) {
        final data = response.data['data']['services'] as List;

        //print(data);

        ref.read(productProvider.notifier).state =
            data.map((json) => ServicesModel.fromJson(json)).toList();
      } else {}
    } catch (e) {
      print("Error fetching appointments: $e");
      throw Exception("Failed to load data");
    }
  }

  Future<void> profileApi(WidgetRef ref) async {
    try {
      final response = await ApiService.postRequest(getProfile, {
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
