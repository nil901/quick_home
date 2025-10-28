import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/model/notification_model.dart';

class NotificationNotifier
    extends StateNotifier<AsyncValue<NotificationModel>> {
  final ApiService _apiService;

  NotificationNotifier(this._apiService) : super(const AsyncValue.loading());

  Future<void> fetchNotifications(String token, String userId) async {
    try {
      state = const AsyncValue.loading();
      final response = await _apiService.getNotifications(token, userId);
      state = AsyncValue.data(response);
    } catch (e, st) {
      print("❌ Provider Error: $e");
      state = AsyncValue.error(e, st);
    }
  }
}
