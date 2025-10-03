import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/app/routes/app_routes.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

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

                    Get.toNamed(Routes.SEARCH);
                  },
                  child: Container(
                    height: mq.size.height * 0.05,
                    padding: EdgeInsets.symmetric(
                      horizontal: mq.size.width * 0.03,
                    ),
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
                        Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                          size: mq.size.width * 0.05,
                        ),
                        SizedBox(width: mq.size.width * 0.02),
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

              /// Bookmark button
              Container(
                decoration: const BoxDecoration(),
                child: IconButton(
                  icon: const Icon(Icons.bookmark_border_rounded),
                  iconSize: mq.size.width * 0.075,
                  color: Colors.white,
                  onPressed: () {
                    // nanti bisa diarahkan ke halaman bookmark
                    Get.toNamed(Routes.BOOKMARK);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
