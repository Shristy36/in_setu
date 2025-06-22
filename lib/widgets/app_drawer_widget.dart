import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/views/login_view/sign_in_screen.dart';
import 'package:in_setu/views/user/profile_screen.dart';
import 'package:in_setu/widgets/bottomnav.dart';

Widget getDrawerItems(BuildContext context) {
  return Drawer(
    child: Column(
          children: [
            // Your header content
            Container(
              width: double.infinity,
              height: 200,
              color: AppColors.primary,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, size: 35, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Kurshid Kulmani",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "CTO",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Your list items
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavScreen())),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  ),
            ),
            ListTile(
              leading: Icon(Icons.delete_forever_sharp, color: Colors.red),
              title: Text('Delete Account'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: Text(
                "App Version 1.0.0",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
    ),
  );
}
