import 'package:flutter/material.dart';

class ManpowerLoadingScreen extends StatelessWidget {
  const ManpowerLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: 5, // show 3 skeleton cards
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Bar
              Container(
                height: 20,
                width: 150,
                color: Colors.grey[400],
                margin: const EdgeInsets.only(bottom: 12),
              ),
              // Staff bar
              Container(
                height: 16,
                width: double.infinity,
                color: Colors.grey[350],
                margin: const EdgeInsets.only(bottom: 8),
              ),
              // Manpower bar
              Container(
                height: 16,
                width: double.infinity,
                color: Colors.grey[350],
                margin: const EdgeInsets.only(bottom: 8),
              ),
              // Task bar
              Container(
                height: 16,
                width: 200,
                color: Colors.grey[350],
              ),
            ],
          ),
        );
      },
    );
  }
}

