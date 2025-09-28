import 'package:flutter/material.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/models/models.dart';
import '../widgets/profile_header.dart';
import '../widgets/custom_tab_bar.dart';
import 'content_tab/content_tab.dart';
import 'statistic_tab/statistic_tab.dart';

class OtherProfilePage extends StatelessWidget {
  final UserProfile userProfile;
  
  const OtherProfilePage({
    super.key,
    required this.userProfile,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Profil ${userProfile.name}',
            style: AppTextStyle.bodyText.copyWith(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Profile Header
            ProfileHeader(
              name: userProfile.name,
              title: userProfile.institution,
              imageAsset: 'assets/images/example-profile.jpg', // Default image
            ),
            
            // Custom Tab Bar
            const CustomTabBar(
              tabs: ['Konten', 'Statistik'],
            ),
            
            // Tab Views
            const Expanded(
              child: TabBarView(
                children: [
                  ContentTab(),
                  StatusTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
