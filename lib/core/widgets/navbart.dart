import 'package:flutter/material.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:schoolshare/features/home/presentation/pages/home_page.dart';
import 'package:schoolshare/core/widgets/notif.dart';
import 'package:schoolshare/features/own_profile/profile.dart';

class NavBarScreen extends StatelessWidget {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      Notif(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_outlined),
        title: "Beranda", 
        activeColorPrimary: AppColor.componentColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications_outlined),
        title: "Notifikasi",
        activeColorPrimary: AppColor.componentColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_outline_sharp),
        title: "Profil",
        activeColorPrimary: AppColor.componentColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style3,
    );
  }
}