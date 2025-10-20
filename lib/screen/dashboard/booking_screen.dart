import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:quick_home/color/colors.dart';
import 'package:quick_home/util/enum.dart';

/// Dummy API Simulation Provider (तुझ्या API ने replace करायचं)
final bookingsProvider =
    FutureProvider.family<List<Map<String, String>>, BookingTab>((
      ref,
      tab,
    ) async {
      await Future.delayed(const Duration(milliseconds: 500));

      final data = {
        BookingTab.inProgress: [
          {
            "title": "Home Deep Cleaning",
            "desc": "Comprehensive cleaning for a spotless and fresh home.",
            "date": "Friday, Sep 28",
            "status": "In Progress",
            "image": "assets/images/booking_service.png",
          },
          {
            "title": "Plumbing Service",
            "desc": "Quick fixes for leaks, pipe issues, and water problems.",
            "date": "Friday, Sep 28",
            "status": "In Progress",
            "image": "assets/images/booking_service.png",
          },
        ],
        BookingTab.upcoming: [
          {
            "title": "AC Service",
            "desc": "Cooling checkup & cleaning by certified experts.",
            "date": "Monday, Oct 2",
            "status": "Upcoming",
            "image": "assets/images/booking_service.png",
          },
        ],
        BookingTab.completed: [
          {
            "title": "Car Wash",
            "desc": "Professional car wash and detailing service.",
            "date": "Monday, Sep 20",
            "status": "Completed",
            "image": "assets/images/booking_service.png",
          },
        ],
        BookingTab.cancelled: [
          {
            "title": "Electrician",
            "desc": "Fix wiring and electrical issues.",
            "date": "Sunday, Sep 10",
            "status": "Cancelled",
            "image": "assets/images/booking_service.png",
          },
        ],
      };

      return data[tab] ?? [];
    });

/// Main Screen
class MyBookingsScreen extends ConsumerStatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  ConsumerState<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends ConsumerState<MyBookingsScreen> {
  BookingTab selectedTab = BookingTab.inProgress;

  final tabNames = const {
    BookingTab.inProgress: "In Progress",
    BookingTab.upcoming: "Upcoming",
    BookingTab.completed: "Completed",
    BookingTab.cancelled: "Cancelled",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            ref.read(bottomTabProvider.notifier).state = BottomTab.home;
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        backgroundColor: kscoundPrimaryColor,
        titleSpacing: 0,
        title: const Text("My Bookings", style: TextStyle(fontSize: 18)),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Horizontal List Tabs
          Container(
            color: kscoundPrimaryColor,
            height: 48,
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                itemCount: tabNames.length,
                itemBuilder: (context, index) {
                  final tab = tabNames.keys.elementAt(index);
                  final isSelected = tab == selectedTab;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = tab;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade900 : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.blue.shade900,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          tabNames[tab]!,
                          style: TextStyle(
                            color:
                                isSelected
                                    ? Colors.white
                                    : Colors.blue.shade900,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// Booking List
          Expanded(child: _buildBookingList(selectedTab)),
        ],
      ),
    );
  }

  Widget _buildBookingList(BookingTab tab) {
    final asyncData = ref.watch(bookingsProvider(tab));

    return asyncData.when(
      data: (list) {
        if (list.isEmpty) {
          return const Center(child: Text("No Bookings"));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final booking = list[index];
            return BookingCard(
              imageUrl: booking["image"]!,
              title: booking["title"]!,
              description: booking["desc"]!,
              status: booking["status"]!,
              date: booking["date"]!,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text("Error: $e")),
    );
  }
}

/// Booking Card
class BookingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String status;
  final String date;

  const BookingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: HexColor("#E2E2E2"), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: HexColor("#E2E2E2"), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(imageUrl, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 12),

              /// Right Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kprimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: HexColor("#353535"),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Divider(color: Colors.grey.shade300, thickness: 1),
                    const SizedBox(height: 4),

                    /// Status + Date row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: backgroundColor(status),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                color: getStatusColor(status),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: kprimary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: Text(date, style: TextStyle(color: kwhite)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Helpers
Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case "upcoming":
      return Colors.blue;
    case "completed":
      return Colors.green;
    case "cancelled":
      return Colors.red;
    case "in progress":
      return HexColor("#00B342");
    default:
      return Colors.grey;
  }
}

Color backgroundColor(String status) {
  return HexColor("#E4F9FF");
}
