import 'package:flutter/material.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Pages/search/search_page.dart';

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchPage()),
                    );
                  },
                  child: Container(
                    height: mq.size.height * 0.05,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: const [
                        Icon(Icons.search_rounded, color: Colors.grey, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "Cari publikasi...",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
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
                  iconSize: 30,
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
