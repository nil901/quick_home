import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/model/address_model.dart';
import 'package:quick_home/model/bannar_model.dart';

class cartServices {
  Future<void> addressApi(WidgetRef ref) async {
    // print("helowwckxckdnkdfn");
    try {
      final response = await ApiService.postRequest(addresses, {"user": 11});
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
}
