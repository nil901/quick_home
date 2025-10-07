// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:quickhome/util/app_bar.dart';
//
// class UserInfoScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: HexColor('#FFFFFF'),
//       appBar: CustomAppBar(title: 'User Info'),
//       body: Column(
//         children: [
//           const SizedBox(height: 30),
//           Center(
//             child: Stack(
//               children: [
//                 // Profile Avatar
//                 Container(
//                   width: 86,
//                   height: 86,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     border: Border.all(color: const Color(0xFF004271), width: 2),
//                   ),
//                   child: const Icon(Icons.person, color: Color(0xFF004271), size: 60),
//                 ),
//                 // Camera Icon Overlay
//                 Positioned(
//                   bottom: 6,
//                   right: 6,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.black12, width: 1),
//                     ),
//                     padding: const EdgeInsets.all(3),
//                     child: const Icon(Icons.photo_camera, size: 18, color: Colors.black45),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 30),
//
//           // TextFields
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 22),
//             child: Column(
//               children: [
//                 _roundedTextField('Name*', keyboardType: TextInputType.name),
//                 const SizedBox(height: 15),
//                 _roundedTextField('Phone Number*', keyboardType: TextInputType.phone),
//                 const SizedBox(height: 15),
//                 _roundedTextField('Email Address*', keyboardType: TextInputType.emailAddress),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // 🔹 Custom Rounded TextField Widget
//   Widget _roundedTextField(String hintText, {TextInputType keyboardType = TextInputType.text}) {
//     return Container(
//       width: 349,
//       height: 49,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: HexColor('#EAEAEA'), width: 0.25),
//         boxShadow: [
//           BoxShadow(
//             color: HexColor('#0000000D'),
//             offset: const Offset(0, 4),
//             blurRadius: 4,
//           ),
//         ],
//       ),
//       child: TextField(
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           hintText: hintText,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
//           filled: true,
//           fillColor: Colors.white,
//
//           // 🔹 Border styles
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: const BorderSide(color: Colors.black12),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: const BorderSide(color: Colors.black12),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: BorderSide(color: HexColor('#004271'), width: 1.5), // 👈 Focus color added here
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../util/custom_app_bar.dart';


class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  XFile? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      if (await Permission.photos.isDenied || await Permission.photos.isRestricted) {
        // Android 13+
        status = await Permission.photos.request();
      } else {
        status = await Permission.storage.request(); // Android 12 and below
      }
    } else {
      // iOS
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gallery permission denied!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#FFFFFF'),
      appBar: CustomAppBar(title: 'User Info'),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Stack(
              children: [
                // Profile Avatar
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF004271), width: 2),
                  ),
                  child: ClipOval(
                    child: _imageFile != null
                        ? Image.file(
                      File(_imageFile!.path),
                      fit: BoxFit.cover,
                    )
                        : const Icon(Icons.person, color: Color(0xFF004271), size: 60),
                  ),
                ),
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: _pickImageFromGallery, // 👈 gallery open function
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12, width: 1),
                      ),
                      padding: const EdgeInsets.all(3),
                      child: const Icon(Icons.photo_camera, size: 18, color: Colors.black45),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // TextFields
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                _roundedTextField('Name*', keyboardType: TextInputType.name),
                const SizedBox(height: 15),
                _roundedTextField('Phone Number*', keyboardType: TextInputType.phone),
                const SizedBox(height: 15),
                _roundedTextField('Email Address*', keyboardType: TextInputType.emailAddress),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundedTextField(String hintText, {TextInputType keyboardType = TextInputType.text}) {
    return Container(
      width: 349,
      height: 49,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: HexColor('#EAEAEA'), width: 0.25),
        boxShadow: [
          BoxShadow(
            color: HexColor('#0000000D'),
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: TextField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: HexColor('#004271'), width: 1.5),
          ),
        ),
      ),
    );
  }
}
