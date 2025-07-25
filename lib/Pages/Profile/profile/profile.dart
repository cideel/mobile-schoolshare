import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Pages/Profile/profile/profile_tab.dart';
import 'package:schoolshare/Pages/Profile/profile/research_tab.dart';
import 'package:schoolshare/Pages/Profile/profile/stats_tab.dart';

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
            expandedHeight: 280, // tinggi saat header full
            pinned: true,
            floating: false,
            elevation: innerBoxIsScrolled ? 4 : 0,
            actions: const [
              Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.settings, color: Colors.black),
              ),
            ],
            flexibleSpace: const FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.only(top: 60),
                child: ProfileHeader(), // header custom kamu
              ),
              collapseMode: CollapseMode.parallax,
            ),
            bottom: TabBar(
              dividerColor: Colors.grey,
              indicatorColor: AppColor.componentColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontSize: 15),
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
