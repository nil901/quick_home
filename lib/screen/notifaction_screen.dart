import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/model/notifaction_model.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  bool showUnread = false;

  bool isLoading = false;

  Future<void> notifactionApi(WidgetRef ref) async {
    // ref.read(notifactionProvider.notifier).state = [];

    try {
      setState(() => isLoading = true);

      final response = await ApiService.postRequest(getNotifications, {
        "user": AppPreference().getInt(PreferencesKey.userId),
      });
      if (response.data['status'] == true) {
        final data = response.data['data']['notifications'] as List;
        ref.read(notifactionProvider.notifier).state =
            data.map((json) => NotifactionModel.fromJson(json)).toList();
      } else {
        print("Failed: ${response.data['message']}");
      }
    } catch (e) {
      print("Error fetching search results: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    notifactionApi(ref);
    super.initState();
  }

  @override
Widget build(BuildContext context) {
  final notifications = ref.watch(notifactionProvider);
  final filteredNotifications = showUnread
      ? notifications.where((n) => n.readAt == null).toList()
      : notifications;

  return Scaffold(
    backgroundColor: kwhite,
    appBar: AppBar(
      backgroundColor: kscoundPrimaryColor,
      titleSpacing: 0,
      title: const Text("Notifications", style: TextStyle(fontSize: 18)),
      actions: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Tab Switch Row
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => showUnread = false),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: showUnread ? Colors.transparent : kprimary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "All",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: showUnread ? Colors.black54 : Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => setState(() => showUnread = true),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: showUnread ? kprimary : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Unread",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: showUnread ? kwhite : Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Expanded(
            child: ListView.builder(
              itemCount: filteredNotifications.length,
              itemBuilder: (context, index) {
                final item = filteredNotifications[index];
                final isUnread = item.readAt == null;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () async {
                      if (isUnread) {
                        try {
                          final response =
                              await ApiService.postRequest(getnotifactionRead, {
                            "user":
                                AppPreference().getInt(PreferencesKey.userId),
                            "notificationid": item.id.toString(),
                          });

                          if (response.data['status'] == true) {
                            // Refresh list
                            notifactionApi(ref);
                          }
                        } catch (e) {
                          print("Error marking read: $e");
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                        color: isUnread
                            ? Colors.green.withOpacity(0.05)
                            : Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isUnread)
                            Container(
                              margin: const EdgeInsets.only(right: 12, top: 8),
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            )
                          else
                            const SizedBox(width: 24),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.data!.title.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.data!.description.toString(),
                                  style:
                                      const TextStyle(color: Colors.black54),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item.data!.time.toString(),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
}