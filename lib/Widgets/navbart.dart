import 'package:flutter/material.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Pages/Profile/profile.dart';
import 'package:schoolshare/Pages/home/home_page.dart';
import 'package:schoolshare/Pages/notif.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:get/get.dart'; // Tambahkan impor GetX
import 'package:schoolshare/Services/home_services.dart'; // Impor HomeServices
import 'package:schoolshare/Controller/home/home_controller.dart';
import 'package:schoolshare/Services/realtime_services.dart'; // Impor HomeController

class NavBarScreen extends StatelessWidget {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  // Daftarkan semua dependensi di dalam konstruktor.
  // Ini memastikan mereka siap saat NavBarScreen pertama kali dibuat.
  NavBarScreen({super.key}) {
    Get.put(HomeServices());
    Get.put(RealtimeService());
    Get.put(HomeController());
  }

  List<Widget> _buildScreens() {
    return [
      const Home(),
      const Notif(),
      const Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: "Beranda",
        activeColorPrimary: AppColor.componentColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.notifications_outlined),
        title: "Notifikasi",
        activeColorPrimary: AppColor.componentColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_outline_sharp),
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
      navBarStyle: NavBarStyle.style3, // Anda bisa mengganti dengan gaya lain.
    );
  }
}
