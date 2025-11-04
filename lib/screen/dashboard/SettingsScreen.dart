import 'package:flutter/material.dart';
import 'package:quick_home/color/colors.dart';
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
                        (context) => WebViewScreen(
                          url: "https://admin.qwikhom.ae/privacy-policy",
                        ),
                  ),
                );
              },
            ),
            _buildSettingsTile(
              icon: Icons.description_outlined,
              title: 'Terms & Conditions',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.delete_outline,
              title: 'Delete Account',
              textColor: Colors.red,
              iconColor: Colors.red, // ✅ red icon to match screenshot
              onTap: () {},
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
}
