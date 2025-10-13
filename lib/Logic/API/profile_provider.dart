import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:quick_home/Logic/Model/profile_model.dart';

// 🔹 Profile Provider
final profileProvider = StateProvider<ProfileModel?>((ref) => null);

// 🔹 Function to fetch profile from API
Future<void> fetchUserProfile(WidgetRef ref, String token) async {
  final url = Uri.parse(
    "http://admin.qwikhom.ae/api/profile",
  ); 

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // agar API token based hai
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['user'] != null) {
        final profile = ProfileModel.fromJson(data['user']);
        ref.read(profileProvider.notifier).state = profile;
      } else {
        ref.read(profileProvider.notifier).state = null;
        print("Failed to load profile: ${data['message']}");
      }
    } else {
      ref.read(profileProvider.notifier).state = null;
      print("Server Error: ${response.statusCode}");
    }
  } catch (e) {
    ref.read(profileProvider.notifier).state = null;
    print("Profile API Error: $e");
  }
}
