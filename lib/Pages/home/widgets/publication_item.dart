import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'author_name.dart';

class PublicationItem extends StatelessWidget {
  final VoidCallback? onTap;
  const PublicationItem({super.key,this.onTap});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: mq.size.height * 0.02),
        child: Column(
          children: [
            const Divider(thickness: 0.5, color: Colors.grey),
            SizedBox(height: mq.size.height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/example-profile.jpg"),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("John Snow",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold)),
                        Text("SMKN 31 Jakarta",
                            style: TextStyle(fontSize: 12.sp)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: mq.size.height * 0.015),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(color: Colors.grey, width: 0.3),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Proximate Analysis of Merang Mushrooms (Volvariella volvacea)...",
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        color: AppColor.componentColor,
                        child: const Text(
                          "Publikasi",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text("12 Agustus 2023", style: TextStyle(fontSize: 12.sp)),
                      const SizedBox(height: 10),
                      const AuthorName(
                          img: 'assets/images/example-profile.jpg', name: "John Snow"),
                      const SizedBox(height: 5),
                      const AuthorName(
                          img: 'assets/images/example-profile-2.jpg',
                          name: "Ratandi Ahmad Fauzan"),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text("66 Dibaca", style: TextStyle(fontSize: 13.sp)),
                          const Text("  •  "),
                          Text("5 Rekomendasi", style: TextStyle(fontSize: 13.sp)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: mq.size.height * 0.015),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActionIcon(icon: Icons.bookmark_outline, label: "Simpan"),
                  ActionIcon(icon: Icons.thumb_up_outlined, label: "Rekomendasi"),
                  ActionIcon(icon: Icons.share_outlined, label: "Bagikan"),
                ],
              ),
            ),
            
            const Divider(thickness: 1),
          ],
        ),
      ),
    );
  }
}

class ActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActionIcon({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }
}
