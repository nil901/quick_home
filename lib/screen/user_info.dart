import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';
import 'package:quick_home/provide/home_prov.dart';
import 'package:quick_home/util/size.dart';
import '../util/custom_app_bar.dart';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';



class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({super.key});

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  XFile? _imageFile;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  // 🟢 Image picker from gallery
Future<void> _pickImageFromGallery() async {
  PermissionStatus status;

  if (Platform.isAndroid) {
    // Android 13 (API 33) and above → use READ_MEDIA_IMAGES
    if (await Permission.photos.isGranted ||
        await Permission.mediaLibrary.isGranted ||
        await Permission.storage.isGranted) {
      status = PermissionStatus.granted;
    } else {
      if (await Permission.mediaLibrary.isDenied ||
          await Permission.mediaLibrary.isRestricted) {
        status = await Permission.mediaLibrary.request();
      } else if (await Permission.storage.isDenied ||
          await Permission.storage.isRestricted) {
        status = await Permission.storage.request();
      } else {
        status = await Permission.photos.request();
      }
    }
  } else {
    status = await Permission.photos.request();
  }

  if (status.isGranted) {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  } else {
    openAppSettings(); // 👈 opens settings if user denied permanently
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Gallery permission denied! Please allow it in Settings.')),
    );
  }
}


  // 🟢 API call with Dio
  Future<void> updateProfile({
    required  userId,
    required String name,
    required String email,
    required String phone,
    File? imageFile,
  }) async {
    final dio = Dio();
    const url = "http://admin.qwikhom.ae/api/update-profile";

    FormData formData = FormData.fromMap({
      'user': userId,
      'name': name,
      'email': email,
      'phone': phone,
      if (imageFile != null)
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
    });

    try {
      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {'Accept': 'application/json'},
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200) {
      HomeServices(). profileApi(ref);
        print("✅ Profile updated successfully");
        print(response.data);
      } else {
        print("❌ Failed: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print("🚫 Error updating profile:");
      if (e.response != null) {
        print("Status: ${e.response?.statusCode}");
        print("Data: ${e.response?.data}");
      } else {
        print(e.message);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    final profile = ref.read(profileProvider);
    if (profile != null) {
      _nameController.text = profile.name ?? '';
      _emailController.text = profile.email ?? '';
      _phoneController.text = profile.phone ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: HexColor('#FFFFFF'),
      appBar: AppBar(
        title: const Text('User Info'),
        backgroundColor: kscoundPrimaryColor,
        foregroundColor: kwhite,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: kprimary, width: 2),
                    ),
                    child: ClipOval(
                      child: _imageFile != null
                          ? Image.file(
                              File(_imageFile!.path),
                              fit: BoxFit.cover,
                            )
                          : (profile?.imageUrl != null &&
                                  profile!.imageUrl!.isNotEmpty)
                              ? Image.network(
                                  profile.imageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>  Icon(
                                    Icons.person,
                                    color: kprimary,
                                    size: 60,
                                  ),
                                )
                              :  Icon(
                                  Icons.person,
                                  color: kprimary,
                                  size: 60,
                                ),
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: _pickImageFromGallery,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black12, width: 1),
                        ),
                        padding: const EdgeInsets.all(3),
                        child: const Icon(
                          Icons.photo_camera,
                          size: 18,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  _roundedTextField(
                    controller: _nameController,
                    label: 'Name*',
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 15),
                  _roundedTextField(
                    controller: _phoneController,
                    label: 'Phone Number*',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 15),
                  _roundedTextField(
                    controller: _emailController,
                    label: 'Email Address*',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  h20,
                  InkWell(
                    onTap: () async {
                      setState(() => isLoading = true);

                      await updateProfile(
                        userId: AppPreference().getInt(PreferencesKey.userId),
                        name: _nameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        imageFile:
                            _imageFile != null ? File(_imageFile!.path) : null,
                      );

                      setState(() => isLoading = false);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text("Profile updated successfully ✅")),
                      );
                    },
                    child: Container(
                      height: 45,
                      width: 300,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kprimary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2)
                          : const Text(
                              "Update",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Custom TextField Widget
  Widget _roundedTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

  Widget _roundedTextField(
    String hintText, {
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
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
        controller: controller, // ✅ controller added here
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 12,
          ),
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

