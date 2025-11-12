import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/screen/dashboard/booking_screen.dart';
import 'package:quick_home/screen/dashboard/home_Screen.dart';
import 'package:quick_home/screen/dashboard/profilr_screen.dart';
import 'package:quick_home/screen/dashboard/wishlist_screen.dart';
import 'package:quick_home/util/enum.dart';

class MainHomeScreen extends ConsumerStatefulWidget {
  final BottomTab initialTab;

  MainHomeScreen({required this.initialTab});

  @override
  ConsumerState<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends ConsumerState<MainHomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(bottomTabProvider.notifier).state = widget.initialTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(bottomTabProvider);

    final Map<BottomTab, Widget> pages = {
      BottomTab.home: Home(),
      BottomTab.bookings: MyBookingsScreen(),
      BottomTab.Wishlist: WishlistScreen(),
      BottomTab.profile: MyProfileScreen(),
    };

    return Scaffold(
      backgroundColor: kwhite,
      body: Stack(
        children: [
          /// ✅ Prevent Page Content from going behind Bottom Nav Bar
          Padding(
            padding: EdgeInsets.only(
              bottom: 100,
            ), // Safe space for navigation bar
            child: pages[selectedTab]!,
          ),

          /// Bottom Navigation Bar
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
                  backgroundColor: kscoundPrimaryColor,
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
                    _navItem(
                      "assets/images/home.png",
                      "Home",
                      selectedTab == BottomTab.home,
                    ),
                    _navItem(
                      "assets/images/booking.png",
                      "Bookings",
                      selectedTab == BottomTab.bookings,
                    ),
                    _navItem(
                      "assets/images/wishlist_icon.png",
                      "Wishlist",
                      selectedTab == BottomTab.Wishlist,
                    ),
                    _navItem(
                      "assets/images/profile.png",
                      "Profile",
                      selectedTab == BottomTab.profile,
                    ),
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
    String asset,
    String label,
    bool isSelected,
  ) {
    return BottomNavigationBarItem(
      icon: CircleAvatar(
        radius: 18,
        backgroundColor: isSelected ? kprimary : Colors.transparent,
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
