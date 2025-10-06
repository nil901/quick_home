import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/screen/dashboard/selected_address_screen.dart';
import 'package:quick_home/util/custom_app_bar.dart';
import 'package:quick_home/util/size.dart';

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Samiksha Raka",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        w100,
                        Icon(Icons.edit)
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: const Color(0xFFD1D1D1), // #D1D1D1
              thickness: 2,
              height: 40,
            ),

            const SizedBox(height: 16),

            // List of options
            Expanded(
              child: ListView(
                children: [
                  _buildOptionTile(
                    imagePath: "assets/images/user.png",
                    label: "User Info",
                    onTap: () {},
                  ),
                  _buildOptionTile(
                    imagePath: "assets/images/address.png",
                    label: "My Address",
                    onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectedMyAddress(),
                          ),
                        );

                    },
                  ),
                  _buildOptionTile(
                    imagePath: "assets/images/wallet.png",
                    label: "Wallet and Payments",
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
                    imagePath: "assets/images/logout.png",
                    label: "Logout",
                    onTap: () {},
                  ),
                   _buildOptionTile(
                    imagePath: "assets/images/delete.png",
                    label: "Delete Account",
                    onTap: () {},
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
    return Container(
      width: 349,
      height: 49,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // border-radius: 10px
        border: Border.all(
          color: HexColor("#D1D1D1"), // divider jaisa border
          width: 0.25, // border-width: 0.25px
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
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: HexColor("#353535"),
          ),
        ),
        onTap: onTap,
        // trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
      ),
    );
  }

}