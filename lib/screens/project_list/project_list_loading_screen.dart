import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';

class ProjectListLoadingScreen extends StatefulWidget {
  const ProjectListLoadingScreen({super.key});

  @override
  State<ProjectListLoadingScreen> createState() =>
      _ProjectListLoadingScreenState();
}

class _ProjectListLoadingScreenState extends State<ProjectListLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15, bottom: 5),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.colorGray.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 15, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(width: 50, height: 10, color: AppColors.skeletonHighlight),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColors.skeletonHighlight,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Container(
                                width: 200,
                                height: 10,
                                color: AppColors.skeletonHighlight,
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: 150,
                                height: 10,
                                color: AppColors.skeletonHighlight,
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: 100,
                                height: 10,
                                color: AppColors.skeletonHighlight,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
