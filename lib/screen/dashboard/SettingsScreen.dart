import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart' show HexColor;
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/provide/address_provider.dart';
import 'package:quick_home/screen/dashboard/webview.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // ✅ Full screen white
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white, // ✅ AppBar white
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.02,
        ),
        child: Column(
          children: [
            _buildSettingsTile(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              trailing: Switch(
                value: _notifications,
                onChanged: (val) {
                  setState(() {
                    _notifications = val;
                  });
                },
                activeColor: Colors.green,
              ),
            ),
            _buildSettingsTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => WebviewFileUploadScreen(
                          url: "https://admin.qwikhom.ae/privacy-policy",
                        ),
                  ),
                );
              },
            ),
            _buildSettingsTile(
              icon: Icons.description_outlined,
              title: 'Terms & Conditions',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => WebviewFileUploadScreen(
                          url: "https://admin.qwikhom.ae/terms-conditions",
                        ),
                  ),
                );
              },
            ),
            _buildOptionTile(
              imagePath: "assets/images/delete.png",
              label: "Delete Account",
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder:
                      (context) => Center(
                        child: Container(
                          width: 290,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 22,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFE4F9FF),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: HexColor('#C10000'),
                              width: 1,
                            ),
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
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      child: Text("Cancel"),
                                    ),
                                    SizedBox(width: 15),
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: HexColor(
                                          '#C10000',
                                        ), // Red color
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        minimumSize: Size(95, 38),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
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
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    Color? textColor,
    Color? iconColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 0.5,
      color: Colors.white, // ✅ Card white background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? Colors.black),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: textColor ?? Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
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
      width: double.infinity,
      height: 49,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // border-radius: 10px
        border: Border.all(color: HexColor("#D1D1D1"), width: 0.25),
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
