import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/model/home_model.dart';
import 'package:quick_home/model/my_booking_model.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';
import 'package:quick_home/provide/cart_prov.dart';
import 'package:quick_home/screen/dashboard/services_details_screen.dart';
import 'package:quick_home/screen/dashboard/tracking_page.dart';
import 'package:quick_home/util/enum.dart';
import 'package:quick_home/util/no_data_found.dart';

/// Dummy API Simulation Provider (तुझ्या API ने replace करायचं)
// final bookingsProvider =
//     FutureProvider.family<List<Map<String, String>>, BookingTab>((
//       ref,
//       tab,
//     ) async {
//       await Future.delayed(const Duration(milliseconds: 500));

//       final data = {
//         BookingTab.inProgress: [
//           {
//             "title": "Home Deep Cleaning",
//             "desc": "Comprehensive cleaning for a spotless and fresh home.",
//             "date": "Friday, Sep 28",
//             "status": "In Progress",
//             "image": "assets/images/booking_service.png",
//           },
//           {
//             "title": "Plumbing Service",
//             "desc": "Quick fixes for leaks, pipe issues, and water problems.",
//             "date": "Friday, Sep 28",
//             "status": "In Progress",
//             "image": "assets/images/booking_service.png",
//           },
//         ],
//         BookingTab.upcoming: [
//           {
//             "title": "AC Service",
//             "desc": "Cooling checkup & cleaning by certified experts.",
//             "date": "Monday, Oct 2",
//             "status": "Upcoming",
//             "image": "assets/images/booking_service.png",
//           },
//         ],
//         BookingTab.completed: [
//           {
//             "title": "Car Wash",
//             "desc": "Professional car wash and detailing service.",
//             "date": "Monday, Sep 20",
//             "status": "Completed",
//             "image": "assets/images/booking_service.png",
//           },
//         ],
//         BookingTab.cancelled: [
//           {
//             "title": "Electrician",
//             "desc": "Fix wiring and electrical issues.",
//             "date": "Sunday, Sep 10",
//             "status": "Cancelled",
//             "image": "assets/images/booking_service.png",
//           },
//         ],
//       };

//       return data[tab] ?? [];
//     });

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

  bool isLoading = false;
  Future<void> mybookingAPi(WidgetRef ref, {required String type}) async {
    try {
      final data = {
        "user": AppPreference().getInt(PreferencesKey.userId),
        "type": type,
      };
      final response = await ApiService.postRequest(getMyBooking, data);
      if (response.data['success'] == true) {
        final data = response.data['data'] as List;

        ref.read(bookingHistoryProvider.notifier).state =
            data.map((json) => BookingHistoryModel.fromJson(json)).toList();
      } else {
        print("Failed to fetch booking history: ${response.data['message']}");
      }
    } catch (e) {
      print("Error fetching appointments: $e");
      throw Exception("Failed to load data");
    }
  }

  @override
  void initState() {
    super.initState();
    // Default first API call
    mybookingAPi(ref, type: "ongoing");
  }

  @override
  Widget build(BuildContext context) {
    final booking = ref.watch(bookingHistoryProvider);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // 👈 normal back
        return false;
      },
      child: Scaffold(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 6,
                  ),
                  itemCount: tabNames.length,
                  itemBuilder: (context, index) {
                    final tab = tabNames.keys.elementAt(index);
                    final isSelected = tab == selectedTab;

                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          selectedTab = tab;
                          isLoading = true; // loading start
                        });

                        String type = "";
                        switch (tab) {
                          case BookingTab.inProgress:
                            type = "ongoing";
                            break;
                          case BookingTab.upcoming:
                            type = "upcoming";
                            break;
                          case BookingTab.completed:
                            type = "completed";
                            break;
                          case BookingTab.cancelled:
                            type = "cancelled";
                            break;
                        }

                        ref.read(bookingHistoryProvider.notifier).state = [];
                        await mybookingAPi(ref, type: type);

                        setState(() {
                          isLoading = false; // loading ended
                        });
                      },

                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Color(0xff004271) : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Color(0xff004271),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            tabNames[tab]!,
                            style: TextStyle(
                              color:
                                  isSelected ? Colors.white : Color(0xff004271),
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
      ),
    );
  }

  Widget _buildBookingList(BookingTab tab) {
    final booking = ref.watch(bookingHistoryProvider);
    // final asyncData = ref.watch(bookingsProvider(tab));

    return isLoading
        ? Center(child: CircularProgressIndicator())
        : booking.isEmpty
        ? Center(child: NoDataFoundScreen(onRetry: () {}))
        : ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: booking.length,
          itemBuilder: (context, index) {
            final bookings = booking[index];

            // Date format logic
            String formattedDate = "";
            try {
              final scheduledDate = bookings.scheduledDate;
              if (scheduledDate != null && scheduledDate.isNotEmpty) {
                formattedDate = DateFormat(
                  'EEEE, MMM d',
                ).format(DateTime.parse(scheduledDate));
              } else {
                formattedDate = "No date";
              }
            } catch (e) {
              formattedDate = "Invalid date";
            }
            return BookingCard(
              imageUrl: bookings.service!.imageUrl.toString(),
              title: bookings.service!.name!,
              description: bookings.service!.shortDescription!,
              status: bookings.status!,
              date: formattedDate,
              price:
                  "AED ${bookings.totalAmount}", // 👈 Add this line for price
              onViewDetails: () {
                // 👇 Add what happens when "View Details about the Service" is clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ServicesDetailsScreen(
                          serviceId: 2,
                          name: 'Maids - Subscription & on-demand cleaning',
                        ),
                  ),
                );
              },
              selectedTab: tab,
            );
          },
        );
  }
}

class BookingCard extends StatelessWidget {
  final BookingTab selectedTab;
  final String imageUrl;
  final String title;
  final String description;
  final String status;
  final String date;
  final String price;
  final VoidCallback onViewDetails;

  const BookingCard({
    required this.selectedTab,
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.price,
    required this.onViewDetails,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top section (Image + Details)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Image with price below
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: HexColor("#E2E2E2"),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.cover,
                                height: 60,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 12),

                  /// Right Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title + Menu
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: HexColor("#004271"),
                                ),
                              ),
                            ),

                            /// Three Dots Menu
                            /// Three Dots Menu — sirf InProgress & Upcoming me hi dikhega
                            if (selectedTab == BookingTab.inProgress ||
                                selectedTab == BookingTab.upcoming)
                              PopupMenuButton<String>(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.grey.shade300),
                                ),
                                elevation: 8,
                                offset: const Offset(0, 30),
                                onSelected: (value) {
                                  if (value == 'track') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                const UserTrackingPage(),
                                      ),
                                    );
                                  } else if (value == 'cancel') {
                                    print("Cancel pressed");
                                  }
                                },
                                itemBuilder:
                                    (context) => [
                                      PopupMenuItem(
                                        value: 'track',
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: 18,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Track Order',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'cancel',
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.cancel_outlined,
                                              size: 18,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Cancel Order',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.black54,
                                ),
                              ),
                          ],
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

                        /// Status + Date Row
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
                                color: HexColor("#004271"),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                child: Text(
                                  date,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// Bottom clickable text
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Center(
                  child: GestureDetector(
                    onTap: onViewDetails,
                    child: Text(
                      "View Details about the Service",
                      style: TextStyle(
                        color: HexColor("#004271"),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Status color helpers
  Color backgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return HexColor("#004271");
      case 'completed':
        return HexColor("#E8F5E9");
      default:
        return HexColor("#F5F5F5");
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return HexColor("#0057B8");
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
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
