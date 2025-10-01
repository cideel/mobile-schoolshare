import 'package:flutter/material.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/data/models/users_model.dart';
import '../widgets/profile_header.dart';
import '../widgets/custom_tab_bar.dart';
import 'content_tab/content_tab.dart';
import 'statistic_tab/statistic_tab.dart';

class OtherProfilePage extends StatelessWidget {
  final UserModel userProfile;

  const OtherProfilePage({
    super.key,
    required this.userProfile,
  });

  String _getInitials(String name) {
    final parts = name.trim().split(" ");
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    } else {
      return (parts[0][0] + parts.last[0]).toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ambil nama institusi pertama jika ada
    final String institutionName = (userProfile.institutionId != null &&
            userProfile.institutionId!.isNotEmpty)
        ? userProfile.institutionId!.first.toString()
        : "Tidak ada institusi";

    // Buat URL profile
    final String? profileImageUrl =
        (userProfile.profile != null && userProfile.profile!.isNotEmpty)
            ? "${ApiUrls.storageUrl}/${userProfile.profile}"
            : null;

    // Buat initials jika tidak ada foto
    final String initials =
        profileImageUrl == null ? _getInitials(userProfile.name) : '';

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
            // Profile Header dinamis
            ProfileHeader(
              name: userProfile.name,
              title: institutionName,
              imageAsset: profileImageUrl,
              initials: initials.isNotEmpty ? initials : null,
            ),

            // Custom Tab Bar
            const CustomTabBar(
              tabs: ['Konten', 'Statistik'],
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                children: [
                  ContentTab(
                    userProfile: userProfile,
                  ),
                  StatusTab(
                    user: userProfile,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
