import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.colorWhite
        ),
        title: Text(
          "Notification",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/icons/empty.png", width: 100, height: 100,),
                SizedBox(height: 10,),
                Text("No Data Found", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),)
              ],
          ),
        ),
      ),
    );
  }
}
