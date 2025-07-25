import 'package:flutter/material.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Pages/search/search_page.dart';
// import 'package:schoolshare/Pages/search_page.dart'; // ganti dengan halaman search kamu

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
            horizontal: mq.size.width * 0.03,
            vertical: mq.size.height * 0.01,
          ),
          child: Row(
            children: [
              /// ✅ TextField-look-alike Button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchPage()),
                    );
                  },
                  child: Container(
                    height: mq.size.height * 0.055,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: const [
                        Icon(Icons.search_outlined, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(
                          "Cari publikasi....",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: mq.size.width * 0.02),

              /// Bookmark
              IconButton(
                icon: const Icon(Icons.bookmark_border, color: Colors.white),
                iconSize: 28,
                onPressed: () => print("Bookmark diklik!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
