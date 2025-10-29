import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/model/notification_model.dart';

/// ✅ Step 1: Provider declaration
final notificationProvider =
    StateNotifierProvider<NotificationNotifier, AsyncValue<NotificationModel>>(
      (ref) => NotificationNotifier(ApiService()),
    );

/// ✅ Step 2: Notifier class
class NotificationNotifier
    extends StateNotifier<AsyncValue<NotificationModel>> {
  final ApiService _apiService;

  NotificationNotifier(this._apiService) : super(const AsyncValue.loading());

  /// ✅ Step 3: Fetch notifications using token & userId
  Future<void> fetchNotifications(String token, String userId) async {
    try {
      print("🔄 [Provider] Fetching notifications...");
      state = const AsyncValue.loading();

      final response = await _apiService.getNotifications(token, userId);

      print("✅ [Provider] Notifications fetched successfully!");
      print(
        "📦 Total Notifications: ${response.data?.notifications?.length ?? 0}",
      );

      // Optional: Print each notification message
      response.data?.notifications?.forEach((n) {
        print(
          "🛎️ ${n.data?.title ?? 'No Title'} | ${n.data?.description ?? 'No Description'}",
        );
      });

      state = AsyncValue.data(response);
    } catch (e, st) {
      print("❌ [Provider] Error while fetching notifications: $e");
      state = AsyncValue.error(e, st);
    }
  }
}
