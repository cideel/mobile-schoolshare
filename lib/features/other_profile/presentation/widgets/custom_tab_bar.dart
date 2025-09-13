import 'package:flutter/material.dart';
import 'package:schoolshare/core/constants/color.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;

  const CustomTabBar({
    super.key,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
        
          
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: TabBar(
        labelColor: AppColor.componentColor,
        unselectedLabelColor: Colors.grey,
        indicatorColor: AppColor.componentColor,
        indicatorWeight: 3,
        tabs: tabs.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }
}
