import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/screens/chat/chatlist_screen.dart';
import 'package:in_setu/screens/home_page/homescreen.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/screens/mainpower_screen/manpower_screen.dart';
import 'package:in_setu/screens/material_view/material_screen.dart';
import 'package:in_setu/screens/plans_view/plan_screen.dart';
import 'package:in_setu/screens/project_list/model/AllSitesResponse.dart';
import 'package:in_setu/widgets/app_drawer_widget.dart';
import 'package:in_setu/widgets/custom_app_bar.dart';


class BottomNavScreen extends StatefulWidget {
  final int? selectedIndex;
  final User user;
  final Data siteObject;

  const BottomNavScreen({
    super.key,
    this.selectedIndex,
    required this.user,
    required this.siteObject,
  });

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen>
    with TickerProviderStateMixin {
  late int _selectedIndex;
  late List<Widget> _screens;
  bool _isBarsVisible = true;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex ?? 2;

    _screens = [
      StockManagementScreen(siteObject: widget.siteObject, user: widget.user,),
      ManpowerScreen(siteObject: widget.siteObject, user: widget.user,),
      _buildHomeScreen(),
      ProjectPlansScreen(siteObject: widget.siteObject, user: widget.user,),
      ChatListScreen(siteObject: widget.siteObject, user: widget.user,),
    ];
  }

  Widget _buildHomeScreen() {
    return HomeScreen(
      siteObject: widget.siteObject,
      user: widget.user,
      onScrollDirectionChanged: (isVisible) {
        if (_isBarsVisible != isVisible) {
          setState(() {
            _isBarsVisible = isVisible;
          });
        }
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required String img,
    required bool isSvg,
    required String filledImg
  }) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSvg ? isSelected ? SvgPicture.asset(filledImg, width: 20, height: 20, color: isSelected ? AppColors.primary : Colors.grey,) : SvgPicture
                .asset(
              img,
              width: 20,
              height: 20,
              color: isSelected ? AppColors.primary : Colors.grey,) : Image
                .asset(
              img,
              width: 20,
              height: 20,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(height: 2),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? AppColors.primary : Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: getDrawerItems(context),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            if(_selectedIndex != 2)
              APPBarWidget(
                isSiteNameVisible: true,
                user: widget.user,
                siteName: widget.siteObject.siteName!,
                siteId: widget.siteObject.id!,
              ),
            if(_selectedIndex != 2)
              const SizedBox(height: 20,),
            Expanded(child: _screens[_selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child:
        _isBarsVisible
            ? AnimatedSlide(
          offset: const Offset(0, 0),
          duration: const Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.colorGray, width: 0.5)
              /*boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          spreadRadius: 0.5,
                          blurRadius: 5.0,
                          offset: const Offset(0, -2),
                        ),
                      ],*/
            ),
            child: BottomAppBar(
              color: const Color(0xFFF5F5F5),
              /* color: AppColors.colorWhite,*/
              elevation: 5,
              notchMargin: 9.0,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: _buildNavItem(
                        icon: Icons.construction,
                        label: 'Material',
                        index: 0,
                        img: "assets/svg/const_outline.svg",
                        isSvg: true,
                        filledImg: "assets/svg/const_filled.svg"
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: _buildNavItem(
                        icon: Icons.people,
                        label: 'Manpower',
                        index: 1,
                        img: "assets/icons/manpower_img.png",
                        isSvg: false,
                        filledImg: ""
                    ),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  Expanded(
                    child: _buildNavItem(
                        icon: Icons.assignment,
                        label: 'Plan',
                        index: 3,
                        img: "assets/svg/plan_icon.svg",
                        isSvg: true,
                        filledImg: "assets/svg/filled_plan_icon.svg"
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: _buildNavItem(
                        icon: Icons.chat_bubble_outline,
                        label: 'Chat',
                        index: 4,
                        img: "assets/svg/filled_chat_icon.svg",
                        isSvg: true,
                        filledImg: "assets/svg/chat_icon.svg"
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
            : const SizedBox.shrink(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child:
          _isBarsVisible
              ? AnimatedSlide(
            offset: const Offset(0, 0),
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: RawMaterialButton(
                  onPressed: () => _onItemTapped(2),
                  fillColor: AppColors.primary,
                  /*_selectedIndex == 2 ? AppColors.primary : Colors.grey,*/
                  elevation: 0,
                  shape: const CircleBorder(),
                  child: _selectedIndex == 2 ? Image.asset(
                    "assets/icons/ic_home_icon.png", width: 30,
                    height: 35,
                    color: AppColors.tabBarColor,) : Image.asset(
                    "assets/icons/home_outline_icon.png", width: 30,
                    height: 30,
                    color: AppColors.tabBarColor,),
                ),
              ),
            ),
          )
              : const SizedBox.shrink(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
