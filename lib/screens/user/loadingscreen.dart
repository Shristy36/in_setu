
import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';

class LoadingScreens{
  static Widget buildProfileLoadingView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Top section with gray background
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: AppColors.skeletonHighlight),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Loading profile picture
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.skeletonBase, width: 4),
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.skeletonHighlight,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),

          Transform.translate(
            offset: const Offset(0, -20),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Loading name and designation card
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
                          Container(
                            width: 150,
                            height: 24,
                            color: AppColors.skeletonHighlight,
                          ),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 18,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  width: 60,
                                  height: 16,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Loading contact information card
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
                          Container(
                            width: 180,
                            height: 24,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 20),
                          // Loading email row
                          _buildLoadingInfoRow(Colors.grey),
                          const SizedBox(height: 16),
                          // Loading phone row
                          _buildLoadingInfoRow(Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildLoadingInfoRow(Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.circle, color: color, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 14,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 6),
              Container(
                width: 120,
                height: 16,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ],
    );
  }
}