import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/features/search/presentation/pages/main_search/search_page.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColor.componentColor,
      expandedHeight: mq.size.height * 0.08,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mq.size.width * 0.04,
            vertical: mq.size.height * 0.015,
          ),
          child: Row(
            children: [
              /// Search Box
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const SearchPage(),
                      withNavBar: true, // IMPORTANT: This keeps the navbar
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Container(
                    height: mq.size.height * 0.05,
                    padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.03),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded, 
                          color: Colors.grey, 
                          size: mq.size.width * 0.05 // Responsive icon size
                        ),
                        SizedBox(width: mq.size.width * 0.02), // Responsive spacing
                        Text(
                          "Cari publikasi...",
                          style: AppTextStyle.caption.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: mq.size.width * 0.025),

              Container(
                decoration: BoxDecoration(
                ),
                child: IconButton(
                  icon: const Icon(Icons.bookmark_border_rounded),
                  iconSize: mq.size.width * 0.075, // Responsive icon size
                  color: Colors.white,
                  onPressed: () => print("Bookmark diklik!"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
