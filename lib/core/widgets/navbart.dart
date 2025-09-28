import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/controllers/navigation_controller.dart';
import 'package:schoolshare/features/home/presentation/pages/home_page.dart';
import 'package:schoolshare/features/notification/pages/notif.dart';
import 'package:schoolshare/features/own_profile/profile.dart';

class NavBarScreen extends StatelessWidget {
  final NavigationController navigationController = Get.put(NavigationController());

  NavBarScreen({Key? key}) : super(key: key);

  final List<Widget> _pages = [
    const HomePage(),
    const NotifPage(),
    const ProfilePage(),
  ];

  final List<BottomNavigationBarItem> _navItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: "Beranda",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.notifications_outlined),
      activeIcon: Icon(Icons.notifications),
      label: "Notifikasi",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline_sharp),
      activeIcon: Icon(Icons.person),
      label: "Profil",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: navigationController.currentIndex.value,
        children: _pages,
      )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: navigationController.currentIndex.value,
        onTap: navigationController.changePage,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColor.componentColor,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 8,
        backgroundColor: Colors.white,
        items: _navItems,
      )),
    );
  }
}