import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/screens/login_view/sign_in_screen.dart';
import 'package:in_setu/screens/user/profile_screen.dart';
import 'package:in_setu/widgets/bottomnav.dart';

Widget getDrawerItems(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        // Your header content
        ClipPath(
          clipper: BottomLeftRoundedClipper(),
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.primary,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary50.withOpacity(1), // Shadow color
                  offset: Offset(4, 4), // Shadow offset
                  blurRadius: 10, // Shadow blur radius
                  spreadRadius: 2, // Shadow spread radius
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColors.colorAccent,
                    child: Icon(Icons.person, size: 35, color: Colors.white),
                  ),*/
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
        ),

        // Your list items
        ListTile(
          leading: Icon(Icons.home, color: AppColors.primary),
          title: Text('Home', style: TextStyle(color: AppColors.primary)),
          onTap:
              () =>
                  {} /*Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavScreen()))*/,
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
        Spacer(),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.delete_forever, color: Colors.redAccent),
          title: Text(
            'Delete Account',
            style: TextStyle(color: Colors.redAccent, fontSize: 16),
          ),
          onTap: () => Navigator.pop(context),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 70.0),
          child: Text(
            "App Version 1.0.0",
            style: TextStyle(color: Colors.blue, fontSize: 14),
          ),
        ),
      ],
    ),
  );
}

class BottomLeftRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 70); // Start from bottom-left (before curve)
    path.quadraticBezierTo(
      0,
      size.height,
      70,
      size.height,
    ); // Curve for bottom-left

    path.lineTo(
      size.width - 230,
      size.height,
    ); // Straight line until 30px from right
    path.lineTo(size.width, size.height - 75); // Diagonal line upwards
    path.lineTo(size.width, 0); // Top-right corner
    path.lineTo(0, 0); // Back to top-left

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
