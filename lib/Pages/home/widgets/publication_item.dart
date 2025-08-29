import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Config/text_styles.dart';
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
                  CircleAvatar(
                    radius: mq.size.width * 0.065, // Responsive avatar size
                    backgroundImage: AssetImage("assets/images/example-profile.jpg"),
                  ),
                  SizedBox(width: mq.size.width * 0.025), // Responsive spacing
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("John Snow",
                            style: AppTextStyle.cardTitle.copyWith(
                                fontSize: 15.sp)),
                        Text("SMKN 31 Jakarta",
                            style: AppTextStyle.caption.copyWith(fontSize: 12.sp)),
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
                  padding: EdgeInsets.all(mq.size.width * 0.03), // Responsive padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Proximate Analysis of Merang Mushrooms (Volvariella volvacea) Cultivated on Corncob and Rice Bran Media",
                        style: AppTextStyle.titleLarge.copyWith(fontSize: 18.sp),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: mq.size.height * 0.008),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: mq.size.width * 0.015, 
                          vertical: mq.size.height * 0.004
                        ),
                        color: AppColor.componentColor,
                        child: const Text(
                          "Publikasi",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: mq.size.height * 0.008),
                      Text("12 Agustus 2023", style: AppTextStyle.dateText),
                      SizedBox(height: mq.size.height * 0.012),
                      const AuthorName(
                          img: 'assets/images/example-profile.jpg', name: "John Snow"),
                      SizedBox(height: mq.size.height * 0.006),
                      const AuthorName(
                          img: 'assets/images/example-profile-2.jpg',
                          name: "Ratandi Ahmad Fauzan"),
                      SizedBox(height: mq.size.height * 0.012),
                      Row(
                        children: [
                          Text("66 Dibaca", style: AppTextStyle.readCount),
                          const Text("  •  "),
                          Text("5 Rekomendasi", style: AppTextStyle.readCount),
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
    final mq = MediaQuery.of(context);
    return Row(
      children: [
        Icon(icon, size: mq.size.width * 0.05), // Responsive icon size
        SizedBox(width: mq.size.width * 0.01), // Responsive spacing
        Text(label, style: AppTextStyle.caption),
      ],
    );
  }
}
