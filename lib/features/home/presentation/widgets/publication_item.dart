import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import '../../../../data/models/publication.dart';
import 'author_name.dart';

class PublicationItem extends StatelessWidget {
  final Publication publication;
  final VoidCallback? onTap;

  const PublicationItem({
    super.key,
    required this.publication,
    this.onTap,
  });

  String _formatDate(DateTime date) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

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
                    radius: mq.size.width * 0.065,
                    backgroundImage:
                        AssetImage("assets/images/example-profile.jpg"),
                  ),
                  SizedBox(width: mq.size.width * 0.025), // Responsive spacing
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          publication.authors.isNotEmpty
                              ? publication.authors.first
                              : "Penulis Tidak Diketahui",
                          style:
                              AppTextStyle.cardTitle.copyWith(fontSize: 15.sp),
                        ),
                        Text(
                          publication.institutionName,
                          style: AppTextStyle.caption.copyWith(fontSize: 12.sp),
                        ),
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
                  padding: EdgeInsets.all(
                      mq.size.width * 0.03),  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        publication.title,
                        style:
                            AppTextStyle.titleLarge.copyWith(fontSize: 18.sp),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: mq.size.height * 0.008),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.r),
                          color: AppColor.componentColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: mq.size.width * 0.015,
                            vertical: mq.size.height * 0.004),
                        child: Text(
                          publication.type,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: mq.size.height * 0.008),
                      Text(
                        _formatDate(publication.publishedDate),
                        style: AppTextStyle.dateText,
                      ),
                      SizedBox(height: mq.size.height * 0.012),
                      // Authors list
                      ...publication.authors
                          .take(2)
                          .map(
                            (author) => Padding(
                              padding: EdgeInsets.only(
                                  bottom: mq.size.height * 0.006),
                              child: AuthorName(
                                img: 'assets/images/example-profile.jpg',
                                name: author,
                              ),
                            ),
                          )
                          .toList(),
                      SizedBox(height: mq.size.height * 0.012),
                      Row(
                        children: [
                          Text(
                            "${publication.readCount} Dibaca",
                            style: AppTextStyle.readCount,
                          ),
                          const Text("  •  "),
                          Text(
                            "${publication.likeCount} Rekomendasi",
                            style: AppTextStyle.readCount,
                          ),
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
                  ActionIcon(
                      icon: Icons.thumb_up_outlined, label: "Rekomendasi"),
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
        Icon(icon, size: mq.size.width * 0.05),
        SizedBox(width: mq.size.width * 0.01),
        Text(label, style: AppTextStyle.caption),
      ],
    );
  }
}
