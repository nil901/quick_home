import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/screen/dashboard/selected_address_screen.dart';
import '../../util/custom_app_bar.dart';
import '../auth/login_screen.dart';
import '../user_info.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     appBar: CustomAppBar(title: "My Profile"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile info
            Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 28, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, Welcome Back",
                      style: TextStyle(
                        fontSize: 14,
                        color: HexColor("#353535"),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      "Samiksha Raka",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            // Divider(
            //   color: const Color(0xFFD1D1D1), // #D1D1D1
            //   thickness: 2,
            //   height: 40,
            // ),

            const SizedBox(height: 16),

            // List of options
            Expanded(
              child: ListView(
                children: [
                  _buildOptionTile(
                    imagePath: "assets/images/user.png",
                    label: "User Info",
                    onTap: () {
                      // Navigate to User Info Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserInfoScreen(),
                        ),
                      );

                    },
                  ),
                  _buildOptionTile(
                    imagePath: "assets/images/address.png",
                    label: "My Address",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>   SelectedMyAddress(),
                        ),
                      );
                    },
                  ),
                  _buildOptionTile(
                    imagePath: "assets/images/wallet.png",
                    label: "Collections",
                    onTap: () {},
                  ),
                  _buildOptionTile(
                    imagePath: "assets/images/booking.png",
                    label: "My Bookings",
                    onTap: () {},
                  ),
                  _buildOptionTile(
                    imagePath: "assets/images/subscription.png",
                    label: "My Subscriptions",
                    onTap: () {},
                  ),

                  _buildOptionTile(
                    imagePath: "assets/images/setting.png",
                    label: "Settings",
                    onTap: () {},
                  ),

                  _buildOptionTile(
                    imagePath: "assets/images/logout.png", // add your logout icon in assets
                    label: "Logout",
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false, // user must press a button
                        builder: (context) => Center(
                          child: Container(
                            width: 290,
                            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 22),
                            decoration: BoxDecoration(
                              color: HexColor('#E4F9FF'),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5), // #00000080
                                  offset: const Offset(0, 4),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                ),
                              ],
                              border: Border.all(color: HexColor('#004271'), width: 1),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Log Out?",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    "Are you sure you want to log out of your account?",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 22),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Cancel button
                                      ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey.shade300,
                                          foregroundColor: Colors.black87,
                                          elevation: 0,
                                          minimumSize: Size(95, 38),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text("Cancel"),
                                      ),
                                      SizedBox(width: 15),
                                      // Log Out button
                                      ElevatedButton(
                                        onPressed: () {
                                            Navigator.pop(context); // close dialog
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) => LoginScreen()),
                                              );;
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF003A64),
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          minimumSize: Size(95, 38),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text("Log Out"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  _buildOptionTile(
                    imagePath: "assets/images/delete.png", // add delete icon in assets
                    label: "Delete Account",
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Center(
                          child: Container(
                            width: 290,
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 22),
                            decoration: BoxDecoration(
                              color: Color(0xFFE4F9FF),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: HexColor('#C10000'), width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 5),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delete Account",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor('#353535'), // Red color
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    "Are you sure you want to delete your account? This action cannot be undone.",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 22),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: HexColor('#C7C7C7'),
                                          foregroundColor: HexColor('#1C1C1C'),
                                          elevation: 0,
                                          minimumSize: Size(95, 38),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text("Cancel"),
                                      ),
                                      SizedBox(width: 15),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context); // close dialog
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => LoginScreen()),
                                          );
                                          // TODO: add API call to delete account
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: HexColor('#C10000'), // Red color
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          minimumSize: Size(95, 38),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text("Yes"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {


    Color labelColor = label == "Delete Account" ? HexColor("#C10000") : HexColor("#353535");

    return Container(
      width: 349,
      height: 49,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // border-radius: 10px
        border: Border.all(
          color: HexColor("#D1D1D1"),
          width: 0.25,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ListTile(
        leading: Image.asset(
          imagePath,
          width: 22,
          height: 22,
          fit: BoxFit.contain,
          color: label == "Delete Account" ? HexColor("#C10000") : null,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: labelColor,
          ),
        ),
        onTap: onTap,
        // trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
      ),
    );
  }

}