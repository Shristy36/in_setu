import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/views/chat/chatlist_screen.dart';
import 'package:in_setu/views/homescreen.dart';
import 'package:in_setu/views/manpower_screen.dart';
import 'package:in_setu/views/material_screen.dart';
import 'package:in_setu/views/plan_screen.dart';

class BottomNavScreen extends StatefulWidget {
  final int? selectedIndex;
  const BottomNavScreen({super.key, this.selectedIndex});

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late int _selectedIndex;

  final List<Widget> _screens = [
    StockManagementScreen(),
    ManpowerScreen(),
    HomeScreen(),
    ProjectPlansScreen(),
    ChatListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex ?? 2;
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
  }) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Icon(icon, color: isSelected ? AppColors.primary : Colors.grey)),
          const SizedBox(height: 5),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColors.primary : Colors.grey,
              ),overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 9.0,
        height: 60,
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Left side items
                Row(
                  children: [
                    _buildNavItem(
                      icon: Icons.construction,
                      label: 'Material',
                      index: 0,
                    ),
                    const SizedBox(width: 15),
                    _buildNavItem(
                      icon: Icons.people,
                      label: 'Manpower',
                      index: 1,
                    ),
                  ],
                ),

                /// Right side items
                Row(
                  children: [
                    _buildNavItem(
                      icon: Icons.assignment,
                      label: '  Plan ',
                      index: 3,
                    ),
                    const SizedBox(width: 32),
                    _buildNavItem(
                      icon: Icons.chat_bubble_outline,
                      label: ' Chat ',
                      index: 4,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 50.0, // Adjust width as needed
        height: 50.0, // Adjust height as needed
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Makes it circular
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => _onItemTapped(2),
          backgroundColor: _selectedIndex == 2 ? AppColors.primary : Colors.grey,
          tooltip: 'Home',
          elevation: 0,
          child: const Icon(Icons.home, color: Colors.white), // Remove default elevation since we're using Container's shadow
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
