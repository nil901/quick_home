import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/screen/dashboard/booking_screen.dart';
import 'package:quick_home/screen/dashboard/home_Screen.dart';
import 'package:quick_home/screen/dashboard/profilr_screen.dart';
import 'package:quick_home/screen/dashboard/subscription_screen.dart';
import 'package:quick_home/util/enum.dart';





class MainHomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(bottomTabProvider);

    final Map<BottomTab, Widget> pages = {
      BottomTab.home: Home(),
      BottomTab.bookings: MyBookingsScreen(),
      BottomTab.subscription: SubscriptionScreen(),
      BottomTab.profile: MyProfileScreen(),
    };

    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      backgroundColor: kwhite,
      body: Stack(
        children: [
          pages[selectedTab]!,

          Positioned(
            left: 16,
            right: 16,
            bottom: 5,
            child: SafeArea(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BottomNavigationBar(
                  currentIndex: BottomTab.values.indexOf(selectedTab),
                  onTap: (index) {
                    ref.read(bottomTabProvider.notifier).state =
                        BottomTab.values[index];
                  },
                  type: BottomNavigationBarType.fixed,
                  backgroundColor:kscoundPrimaryColor,
                  selectedItemColor: kprimary,
                  unselectedItemColor: Colors.black87,
                  showUnselectedLabels: true,
                  selectedLabelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(fontSize: 12),
                  iconSize: 0,
                  items: [
                    _navItem("assets/images/home.png", "Home",
                        selectedTab == BottomTab.home),
                    _navItem("assets/images/booking.png", "Bookings",
                        selectedTab == BottomTab.bookings),
                    _navItem("assets/images/subscription.png", "Subscription",
                        selectedTab == BottomTab.subscription),
                    _navItem("assets/images/profile.png", "Profile",
                        selectedTab == BottomTab.profile),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navItem(
      String asset, String label, bool isSelected) {
    return BottomNavigationBarItem(
      icon: CircleAvatar(
        radius: 18,
        backgroundColor: isSelected ?kprimary : Colors.transparent,
        child: Image.asset(
          asset,
          color: isSelected ? Colors.white : Colors.black,
          height: 18,
          width: 18,
        ),
      ),
      label: label,
    );
  }
}
