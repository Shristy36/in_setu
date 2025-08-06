import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/views/user/bloc/profile_bloc.dart';
import 'package:in_setu/views/user/loadingscreen.dart';
import 'package:in_setu/views/user/model/ProfileUserResponse.dart';

import 'edit_profile_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = true;
  ProfileUserResponse? profileUserResponse;


  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const GetProfileDetails());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        backgroundColor: AppColors.primary50,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocListener<ProfileBloc, GlobalApiResponseState>(
        listener: (context, state) {
          switch (state.status) {
            case GlobalApiStatus.loading:
              setState(() => _isLoading = true);
              break;
            case GlobalApiStatus.completed:
              if (state is UserProfileStateSuccess) {
                setState(() {
                  _isLoading = false;
                  profileUserResponse = state.data as ProfileUserResponse;
                });
              }
              break;
            case GlobalApiStatus.error:
              setState(() => _isLoading = false);
              ErrorHandler.errorHandle(
                state.message,
                "Something wrong",
                context,
              );
              break;
            default:
              setState(() => _isLoading = false);
          }
        },
        child: _isLoading ?  LoadingScreens.buildProfileLoadingView() : _buildProfileView(),
      )

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
                        child: profileUserResponse!.imagePath != null ? Image.network(
                          ApiConstants.baseUrl + profileUserResponse!.imagePath!,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          width: 120,
                          height: 120,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.person,size: 120, color: Colors.blue,),
                        ):Icon(Icons.person, size: 120, color: Colors.blue,),
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
                          Text(
                            "${profileUserResponse!.data!.firstName}  ${profileUserResponse!.data!.lastName}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Designation:',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.blue[200]!,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "${profileUserResponse!.data!.designation}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Contact Information Card
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
                          const Text(
                            'Contact Information',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Email
                          _buildInfoRow(
                            Icons.email_outlined,
                            'Email',
                            "${profileUserResponse!.data!.emailId}",
                            Colors.red,
                          ),
                          const SizedBox(height: 16),
                          // Phone
                          _buildInfoRow(
                            Icons.phone_outlined,
                            'Phone',
                            "${profileUserResponse!.data!.userMobile}",
                            Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text("Edit Profile", style: TextStyle(color: AppColors.colorWhite, fontSize: 18),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon,
      String label,
      String value,
      Color iconColor,) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}