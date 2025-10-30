import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/provide/address_provider.dart';
import 'package:quick_home/screen/dashboard/booking_screen.dart';
import 'package:quick_home/screen/dashboard/collection.dart';
import 'package:quick_home/screen/dashboard/selected_address_screen.dart';
import 'package:quick_home/screen/dashboard/settings.dart';
import 'package:quick_home/screen/dashboard/subscription_pro.dart';
import 'package:quick_home/screen/dashboard/subscription_screen.dart';
import 'package:quick_home/util/size.dart';
import '../../util/custom_app_bar.dart';
import '../auth/login_screen.dart';
import '../user_info.dart';

class MyProfileScreen extends ConsumerStatefulWidget {
  const MyProfileScreen({super.key});

  @override
  ConsumerState<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends ConsumerState<MyProfileScreen> {
  String _truncateName(String? fullName) {
    if (fullName == null || fullName.isEmpty) return '';
    final parts = fullName.split(' ');
    if (parts.length <= 3) {
      return fullName;
    } else {
      return parts.sublist(0, 3).join(' ') + '...';
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);
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
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey[300],
                  child: ClipOval(
                    child: Image.network(
                      profile?.imageUrl ?? '',
                      fit: BoxFit.cover,
                      width: 56,
                      height: 56,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          size: 35,
                          color: Colors.white,
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                    ),
                  ),
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
                      children: [
                        Text(
                          _truncateName(profile?.name),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        w10,
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserInfoScreen(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.edit,
                            size: 23,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: [
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
                    label: "Collections",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CollectionScreen(),
                        ),
                      );
                    },
                  ),
                  _buildOptionTile(
                    imagePath: "assets/images/booking.png",
                    label: "My Bookings",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyBookingsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildOptionTile(
                    imagePath: "assets/images/subscription.png",
                    label: "My Subscriptions",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SubscriptionScreen1(),
                        ),
                      );
                    },
                  ),
                  _buildOptionTile(
                    imagePath: "assets/images/setting.png",
                    label: "Settings",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildOptionTile(
                    imagePath: "assets/images/logout.png",
                    label: "Logout",
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),
                  _buildOptionTile(
                    imagePath: "assets/images/delete.png",
                    label: "Delete Account",
                    onTap: () {
                      _showDeleteDialog(context);
                    },
                  ),
                  h100,
                ],
              ),
            ),
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
    Color labelColor =
        label == "Delete Account" ? HexColor("#C10000") : HexColor("#353535");

    return Container(
      width: 349,
      height: 49,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: HexColor("#D1D1D1"), width: 0.25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 4),
            blurRadius: 6,
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
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Center(
            child: Container(
              width: 290,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
              decoration: BoxDecoration(
                color: HexColor('#E4F9FF'),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
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
                    const Text(
                      "Log Out?",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      "Are you sure you want to log out of your account?",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.black87,
                            elevation: 0,
                            minimumSize: const Size(95, 38),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(width: 15),
                        ElevatedButton(
                          onPressed: () async {
                            await AddressService().logoutUser(context, ref);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF003A64),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            minimumSize: const Size(95, 38),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Log Out"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Center(
            child: Container(
              width: 290,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
              decoration: BoxDecoration(
                color: const Color(0xFFE4F9FF),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: HexColor('#C10000'), width: 1),
                boxShadow: const [
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
                        color: HexColor('#353535'),
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      "Are you sure you want to delete your account? This action cannot be undone.",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor('#C7C7C7'),
                            foregroundColor: HexColor('#1C1C1C'),
                            elevation: 0,
                            minimumSize: const Size(95, 38),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(width: 15),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            await AddressService().deleteAccount(context, ref);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor('#C10000'),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            minimumSize: const Size(95, 38),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
