import 'package:flutter/material.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/features/own_profile/content_tab/presentation/pages/content_list/content_list_page.dart';
import 'profile_tab/presentation/pages/profile_tab.dart';
import 'statistic_tab/presentation/pages/stats_tab.dart';
import 'widgets/profile_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: MediaQuery.of(context).size.height * 0.35,
              pinned: true,
              floating: false,
              elevation: innerBoxIsScrolled ? 4 : 0,
              actions: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                  child: const Icon(Icons.settings, color: Colors.black),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.075),
                  child: const ProfileHeader(),
                ),
                collapseMode: CollapseMode.parallax,
              ),
              bottom: TabBar(
                dividerColor: Colors.grey,
                indicatorColor: AppColor.componentColor,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: AppTextStyle.cardTitle,
                tabs: const [
                  Tab(text: "Profil"),
                  Tab(text: "Konten"),
                  Tab(text: "Statistik"),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              ProfileTab(),
              // ContentListPage(),
              StatsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
