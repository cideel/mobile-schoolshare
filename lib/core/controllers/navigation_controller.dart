import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../constants/color.dart';
import '../../features/search/presentation/pages/main_search/search_page.dart';
import '../../features/bookmark/pages/bookmark_list_page.dart';
import '../../features/other_profile/presentation/pages/header_other_profile_detail.dart';
import '../../models/models.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;
  
  void changePage(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
    }
  }
  
  void goToHome() => changePage(0);
  void goToNotifications() => changePage(1);
  void goToProfile() => changePage(2);

  // Method untuk navigasi ke page dengan navbar tetap terlihat
  void navigateToPage(Widget page, {bool maintainState = true}) {
    Get.to(
      () => Scaffold(
        body: page,
        bottomNavigationBar: _buildPersistentNavBar(),
      ),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 300),
    );
  }

  // Method khusus untuk navigasi ke detail content
  void navigateToDetail(Widget detailPage) {
    navigateToPage(detailPage);
  }

  // Method untuk navigasi ke search
  void navigateToSearch() {
    navigateToPage(const SearchPage());
  }

  // Method untuk navigasi ke bookmark
  void navigateToBookmark() {
    navigateToPage(const BookmarkListPage());
  }

  // Method untuk navigasi ke profile lain
  void navigateToOtherProfile({required UserProfile userProfile}) {
    navigateToPage(OtherProfilePage(userProfile: userProfile));
  }

  // Method helper untuk testing - navigasi ke sample profile
  void navigateToSampleProfile() {
    final sampleProfile = UserProfile(
      id: 'sample_id',
      name: 'Sample User',
      institution: 'Sample Institution',
      profilePhoto: 'assets/images/example-profile.jpg',
      email: 'sample@example.com',
    );
    navigateToOtherProfile(userProfile: sampleProfile);
  }

  // Method untuk navigasi tanpa navbar (untuk auth pages)
  void navigateWithoutNavbar(Widget page) {
    Get.to(
      () => page,
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 300),
    );
  }

  // Method untuk navigasi ke authentication pages
  void navigateToLogin() {
    // Import login page nanti jika diperlukan
    // navigateWithoutNavbar(LoginPage());
  }

  void navigateToRegister() {
    // Import register page nanti jika diperlukan  
    // navigateWithoutNavbar(RegisterPage());
  }

  // Build navbar yang persistent untuk pages
  Widget _buildPersistentNavBar() {
    return Obx(() => BottomNavigationBar(
      currentIndex: currentIndex.value,
      onTap: (index) {
        changePage(index);
        Get.back(); // Kembali ke main navigation
      },
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
    ));
  }
}
