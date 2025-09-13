import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Config/text_styles.dart';
import 'package:schoolshare/Pages/Profile/tabs/profile_tab.dart';
import 'package:schoolshare/Pages/Profile/tabs/research_tab.dart';
import 'package:schoolshare/Pages/Profile/tabs/stats_tab.dart';

import 'widgets/profile_header.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: MediaQuery.of(context).size.height *
                  0.35, // Responsive height
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
                  Tab(text: "Riset"),
                  Tab(text: "Status"),
                ],
              ),
            ),
          ],
          body: const TabBarView(
            children: [
              ProfileTab(),
              ResearchTab(),
              StatsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
