import 'package:flutter/material.dart';
import 'package:quick_home/color/colors.dart';

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text("Home Page")),
    Center(child: Text("Bookings Page")),
    Center(child: Text("Subscription Page")),
    Center(child: Text("Profile Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kgrey,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  radius: 18,
                  backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.transparent,
                  child: Image.asset("assets/images/home.png",
                      color: _selectedIndex == 0 ? Colors.white : Colors.black,
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover),
                  // child: Icon(Icons.home,
                  //     color: _selectedIndex == 0 ? Colors.white : Colors.black),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  radius: 18,
                  backgroundColor: _selectedIndex == 1 ? Colors.black : Colors.transparent,
                  child: Image.asset("assets/images/booking.png",
                      color: _selectedIndex == 1 ? Colors.white : Colors.black,
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover),
                  // child: Icon(Icons.book,
                  //     color: _selectedIndex == 1 ? Colors.white : Colors.black),
                ),
                label: "Bookings",
              ),
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  radius: 18,
                  backgroundColor: _selectedIndex == 2 ? Colors.black : Colors.transparent,
                  child: Image.asset("assets/images/subscription.png",
                      color: _selectedIndex == 2 ? Colors.white : Colors.black,
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover),
                  // child: Icon(Icons.subscriptions,
                  //     color: _selectedIndex == 2 ? Colors.white : Colors.black),
                ),
                label: "Subscription",
              ),
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  radius: 18,
                  backgroundColor: _selectedIndex == 3 ? Colors.black : Colors.transparent,
                  child: Image.asset("assets/images/profile.png",
                      color: _selectedIndex == 3 ? Colors.white : Colors.black,
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover),
                  // child: Icon(Icons.person,
                  //     color: _selectedIndex == 3 ? Colors.white : Colors.black),
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
