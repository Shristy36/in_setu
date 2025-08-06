import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/screens/cash_details_view/cash_details_view.dart';
import 'package:in_setu/screens/link_device_screen.dart';
import 'package:in_setu/screens/login_view/sign_in_screen.dart';
import 'package:in_setu/screens/notification_view/notificationscreen.dart';
import 'package:in_setu/screens/user/profile_screen.dart';
import 'package:in_setu/widgets/add_cashbook_widget.dart';

import '../screens/login_view/model/LoginAuthModel.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String greetingName;
  final String subText;
  final VoidCallback? onArticleTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onMoreTap;
  final double elevation;
  final EdgeInsetsGeometry padding;

  const CustomAppBar({
    super.key,
    required this.greetingName,
    required this.subText,
    this.onArticleTap,
    this.onNotificationTap,
    this.onMoreTap,
    this.elevation = 1.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 6),
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: padding,
        child: Row(
          children: [
            InkWell(
              onTap: Scaffold.of(context).openDrawer,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFB800), Color(0xFFFFA000)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.folder_open,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, $greetingName',
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subText,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Spacer(),
            _iconButton(icon: Icons.article_outlined, onPressed: onArticleTap),
            _iconButton(
              icon: Icons.notifications_outlined,
              onPressed: onNotificationTap,
            ),
            _iconButton(icon: Icons.more_vert, onPressed: onMoreTap),
          ],
        ),
      ),
    );
  }

  Widget _iconButton({required IconData icon, VoidCallback? onPressed}) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(left: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: const Color(0xFF64748B), size: 18),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class APPBarWidget extends StatelessWidget {
  bool isSiteNameVisible;
  final User user;
  final String siteName;
  final num siteId;
  APPBarWidget({super.key, required this.isSiteNameVisible, required this.user, required this.siteName, required this.siteId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 20),
      child: Row(
        children: [
          // Profile section
          InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.tabBarColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.person_outline, color: Colors.white, size: 28),
            ),
          ),

          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi ,${user.firstName}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Text(
                  "${user.lastName}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                if(isSiteNameVisible)Text(
                  siteName,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          // Action buttons
          GestureDetector(
            onTap: ()=>{
              Navigator.push(context, MaterialPageRoute(builder: (context) => CashDetailsView(siteId: siteId)))
            },
              child: Icon(Icons.description_outlined, color: Colors.grey[600])),
          SizedBox(width: 20),
          GestureDetector(
              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen())),child: Icon(Icons.notifications_outlined, color: Colors.grey[600])),
          SizedBox(width: 5),
          // Icon(Icons.more_vert, color: Colors.grey[600])
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.grey[600]),
            onSelected: (value) {
              if (value == 'link_device') {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LinkDeviceScreen()));
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'link_device',
                child: Row(
                  children: [
                    Icon(Icons.devices_rounded),
                    SizedBox(width: 5,),
                    Text("Link Device"),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

enum MenuAction {
  linkDevice,
}
