import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/features/home/presentation/pages/home_page.dart';
import 'package:schoolshare/core/widgets/notif.dart';
import 'package:schoolshare/features/own_profile/profile.dart';

class AppShell extends StatefulWidget {
  final Widget? child;
  final bool showNavBar;
  
  const AppShell({
    super.key,
    this.child,
    this.showNavBar = true,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    Notif(),
    ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    // Reset navigation stack for each tab
    Get.offAllNamed(_getRouteForIndex(index));
  }

  String _getRouteForIndex(int index) {
    switch (index) {
      case 0:
        return '/home';
      case 1:
        return '/notification';
      case 2:
        return '/profile';
      default:
        return '/home';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child ?? IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: widget.showNavBar ? _buildBottomNavBar() : null,
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTabTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColor.componentColor,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      elevation: 8,
      backgroundColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: "Beranda",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined),
          activeIcon: Icon(Icons.notifications),
          label: "Notifikasi",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_sharp),
          activeIcon: Icon(Icons.person),
          label: "Profil",
        ),
      ],
    );
  }
}
