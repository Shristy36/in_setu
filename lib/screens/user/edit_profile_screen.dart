import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_setu/commonWidget/custom_text_field.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/constants/strings.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _profileImage;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final contactNo = TextEditingController();
  final designerTxt = TextEditingController();
  final emailId = TextEditingController();

  Future<void> _handleImageSource(
    BuildContext context,
    ImageSource source,
  ) async {
    Permission permission;

    if (source == ImageSource.gallery) {
      permission = Platform.isAndroid ? Permission.storage : Permission.photos;
    } else {
      permission = Permission.camera;
    }

    var status = await permission.status;

    if (status.isGranted) {
      await _pickImage(source);
    } else if (status.isDenied || status.isLimited) {
      await showPermissionRationaleDialog(
        context,
        title: 'Permission Required',
        message:
            source == ImageSource.gallery
                ? 'We need access to your gallery to pick an image.'
                : 'We need access to your camera to take a picture.',
        permission: permission,
      );

      if (await permission.isGranted) {
        await _pickImage(source);
      }
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedImage != null) {
        setState(() {
          _profileImage = File(pickedImage.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: ${e.toString()}')),
      );
    }
  }

  static Future<void> showPermissionRationaleDialog(
    BuildContext context, {
    required String title,
    required String message,
    required Permission permission,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                child: const Text('Deny'),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: const Text('Allow'),
                onPressed: () async {
                  Navigator.pop(context);
                  await permission.request();
                },
              ),
            ],
          ),
    );
  }

  void _showEditImageOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Edit Profile Picture",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text(
                  'Take Photo',
                  style: TextStyle(fontSize: 16, color: Colors.black45),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _handleImageSource(context, ImageSource.camera);
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text(
                  'Choose from Gallery',
                  style: TextStyle(fontSize: 16, color: Colors.black45),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _handleImageSource(context, ImageSource.gallery);
                },
              ),
              if (_profileImage != null) ...[
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text(
                    'Remove Photo',
                    style: TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _profileImage = null;
                    });
                  },
                ),
              ],
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        backgroundColor: AppColors.primary50,
        elevation: 0,
        centerTitle: true,
      ),
      body: _buildProfileView(),
    );
  }

  Widget _buildProfileView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Top section with gradient background
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.primary50),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Profile Picture with Edit Button
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child:
                            _profileImage != null
                                ? Image.file(
                                  _profileImage!,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                  width: 120,
                                  height: 120,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Icon(Icons.person),
                                )
                                : Icon(
                                  Icons.person,
                                  size: 120,
                                  color: Colors.blue,
                                ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          _showEditImageOptions(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),

          // Rest of your existing UI remains the same...
          Transform.translate(
            offset: const Offset(0, -20),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Name and Designation Card
                  Card(
                    color: Colors.white,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            validationValue: firstNameIsNotEmpty,
                            controller: firstName,
                            labelText: "First Name",
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 20),

                          CustomTextField(
                            validationValue: lastNameIsNotEmpty,
                            controller: lastName,
                            labelText: "Last Name",
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 20),

                          CustomTextField(
                            validationValue: contactIsNotEmpty,
                            controller: contactNo,
                            labelText: "Contact No",
                            icon: Icons.call,
                          ),
                          const SizedBox(height: 20),

                          CustomTextField(
                            validationValue: designerIsNotEmpty,
                            controller: designerTxt,
                            labelText: "Designation",
                            icon: Icons.add_business,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            validationValue: emailIsNotEmpty,
                            controller: emailId,
                            labelText: "Email",
                            icon: Icons.email,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: AppColors.colorWhite,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
