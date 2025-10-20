import 'package:flutter/material.dart';
import 'package:quick_home/color/colors.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool showUnread = false;

  final List<Map<String, dynamic>> notifications = [
    {
      "title": "Your booking has been confirmed.",
      "subtitle":
          "Your Service is successfully booked. Our professional will reach you on time.",
      "buttonText": "Track",
      "isUnread": true,
    },
    {
      "title": "Your service has started.",
      "subtitle": "The service is now in progress at your location.",
      "buttonText": "View",
      "isUnread": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredNotifications =
        showUnread
            ? notifications.where((n) => n['isUnread'] == true).toList()
            : notifications;

    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: kscoundPrimaryColor,
        titleSpacing: 0,
        title: Text("Notifications", style: TextStyle(fontSize: 18)),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showUnread = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
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
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showUnread = true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: showUnread ?kprimary : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Unread",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: showUnread ?kwhite: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: filteredNotifications.length,
                itemBuilder: (context, index) {
                  final item = filteredNotifications[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Green dot for unread
                          if (item['isUnread'] == true)
                            Container(
                              margin: EdgeInsets.only(right: 12, top: 8),
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            )
                          else
                            SizedBox(width: 24),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  item['subtitle'],
                                  style: TextStyle(color: Colors.black54),
                                ),
                                SizedBox(height: 8),
                               Container(
                                //height: 20,
                                decoration: BoxDecoration(
borderRadius: BorderRadius.circular(10),
border: Border.all(color: kprimary,width: 1.5)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                                  child: Text(item['buttonText'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                ),
                               )
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
      ),
    );
  }
}
