import 'package:flutter/material.dart';
import 'widgets/profile_header.dart';
import 'widgets/custom_tab_bar.dart';
import 'tabs/content_tab.dart';
import 'tabs/status_tab.dart';

class OtherProfilePage extends StatelessWidget {
   OtherProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: const Column(
          children: [
            ProfileHeader(
              name: "Anggito Setoadji",
              title: "Universitas Telkom",
              imageAsset: 'assets/images/example-profile.jpg',
            ),
            CustomTabBar(
              tabs: ['Konten', 'Status']),
            Expanded(
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
