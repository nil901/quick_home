import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/model/bannar_model.dart';
import 'package:quick_home/model/category_model.dart';
import 'package:quick_home/model/serviceModel.dart';
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
Future<void> subCategoriesApi(WidgetRef ref) async {
  // print("helowwckxckdnkdfn");
  try {
    final response = await ApiService.postRequest(services,{
      "category":2
      // "subcategory"
    }
    
    );
    print(response?.data['data']);
    if (response.data['success'] == true) {
      final data = response.data['data']['services'] as List;

      print(data);

      ref.read(serviceModelProvider.notifier).state =
          data.map((json) => ServicesModel.fromJson(json)).toList();
    } else {}
  } catch (e) {
    print("Error fetching appointments: $e");
    throw Exception("Failed to load data");
  }
}
}