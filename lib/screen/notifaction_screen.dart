// ✅ Step 1: Import all required packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';
import 'package:quick_home/provide/notification_provider.dart';
import 'package:quick_home/model/notification_model.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  bool showUnread = false;

  @override
  void initState() {
    super.initState();

    // ✅ Step 2: Fetch notifications from API
    Future.microtask(() async {
      try {
        print("🔄 Fetching notifications from API...");

        // ✅ Get token and userId from preferences
        final token = AppPreference().getString(PreferencesKey.token) ?? '';
        final userId =
            AppPreference().getInt(PreferencesKey.userId)?.toString() ?? '';

        await ref
            .read(notificationProvider.notifier)
            .fetchNotifications(token, userId);

        print("✅ Notifications fetched successfully!");
      } catch (e) {
        print("❌ Error while fetching notifications: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Step 3: Watch provider
    final notificationsAsync = ref.watch(notificationProvider);
    print("📡 Provider State: $notificationsAsync");

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

      // ✅ Step 4: Handle all states
      body: notificationsAsync.when(
        loading: () {
          print("⏳ Notifications loading...");
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, _) {
          print("❌ Provider Error: $error");
          return Center(child: Text("Error: $error"));
        },
        data: (data) {
          print("📩 Raw Notification Data: ${data.toString()}");

          // ✅ Extract notifications list
          final List<NotificationItem> allNotifications =
              data.data?.notifications ?? [];

          print("📬 Total Notifications: ${allNotifications.length}");

          // ✅ Apply filter for unread
          final filteredNotifications =
              showUnread
                  ? allNotifications.where((n) => n.readAt == null).toList()
                  : allNotifications;

          print(
            "📊 Filter Applied: ${showUnread ? "Unread Only" : "All"} | Showing: ${filteredNotifications.length}",
          );

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ✅ Filter Buttons
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("🟢 Showing ALL notifications");
                        setState(() {
                          showUnread = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 12,
                        ),
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
                      onTap: () {
                        print("🟡 Showing only UNREAD notifications");
                        setState(() {
                          showUnread = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 12,
                        ),
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

                // ✅ Notifications List
                Expanded(
                  child:
                      filteredNotifications.isEmpty
                          ? const Center(child: Text("No notifications found."))
                          : ListView.builder(
                            itemCount: filteredNotifications.length,
                            itemBuilder: (context, index) {
                              final item = filteredNotifications[index];
                              final title =
                                  item.data?.title ?? "No title available";
                              final subtitle =
                                  item.data?.description ??
                                  "No description available";
                              final time =
                                  item.data?.time ?? "No time available";
                              final isUnread = item.readAt == null;

                              print(
                                "📨 Notification ${index + 1}: $title | Unread: $isUnread",
                              );

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    color:
                                        isUnread
                                            ? Colors.grey.shade100
                                            : Colors.white,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Green dot for unread
                                      if (isUnread)
                                        Container(
                                          margin: const EdgeInsets.only(
                                            right: 12,
                                            top: 8,
                                          ),
                                          width: 12,
                                          height: 12,
                                          decoration: const BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,
                                          ),
                                        )
                                      else
                                        const SizedBox(width: 24),

                                      // Message + Time + Button
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              subtitle,
                                              style: const TextStyle(
                                                color: Colors.black54,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              time,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            GestureDetector(
                                              onTap: () {
                                                print(
                                                  "👁️‍🗨️ View tapped for: $title",
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: kprimary,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 7,
                                                  ),
                                                  child: Text(
                                                    "View",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
