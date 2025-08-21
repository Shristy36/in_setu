import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/screens/login_view/account_delete_dialog/account_delete_dialog.dart';
import 'package:in_setu/screens/login_view/account_delete_dialog/logout_dialog.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/screens/user/profile_screen.dart';
import 'package:in_setu/supports/share_preference_manager.dart';

Widget getDrawerItems(BuildContext context) {
  return FutureBuilder<User?>(
      future: getUserDetails(),
      builder: (context, snapshot){
        if (!snapshot.hasData) {
          return const Drawer(child: Center(child: CircularProgressIndicator()));
        }
        User user = snapshot.data!;
        return Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero
          ),
          child: SafeArea(
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
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${user.firstName} ${user.lastName}",
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
                                    "${user.designation}",
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
                  leading: Image.asset("assets/icons/home_outline_icon.png", width: 25,height: 25, color: AppColors.primary,),
                  title: Text('Home', style: TextStyle(color: AppColors.primary)),
                  onTap:
                      () =>
                  {Navigator.of(context).pop()} /*Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavScreen()))*/,
                ),
                ListTile(
                  leading: SvgPicture.asset("assets/svg/person_out.svg", width: 25, height: 25,),
                  title: Text('Profile'),
                  onTap:
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  ),
                ),
                Spacer(),
                ListTile(
                  leading: SvgPicture.asset("assets/svg/logout_icon.svg", width: 25, height: 25,),
                  title: Text('Logout'),
                  onTap: (){
                    LogoutDialog.showLogoutDialog(context);
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset("assets/svg/delete_icon.svg", width: 25, height: 25, color: Colors.red,),
                  title: Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.redAccent, fontSize: 16),
                  ),
                  onTap: () async{
                    LoginAuthModel? oAuth = await SharedPreferenceManager.getOAuth();
                    if (oAuth != null && oAuth.user != null) {
                      AccountDeleteDialog.showAccountDeleteDialog(context, oAuth.user!.userToken!);
                    }
                  },
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
          ),
        );
      });

}

Future<User?> getUserDetails() async {
  LoginAuthModel? loginModel = await SharedPreferenceManager.getOAuth();
  return loginModel?.user;
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
