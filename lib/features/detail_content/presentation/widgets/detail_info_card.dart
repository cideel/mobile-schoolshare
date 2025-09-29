import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/features/home/presentation/widgets/author_name.dart';
import '../../../../models/content.dart';

class DetailInfoCard extends StatelessWidget {
  final Content? content;
  
  const DetailInfoCard({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(mq.size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _label(content?.type ?? "Publikasi", true),
                  SizedBox(width: mq.size.width * 0.02), // Responsive spacing
                  _label(content?.type == 'Video' ? "Video tersedia" : "Dokumen tersedia", false),
                ],
              ),
              SizedBox(height: mq.size.height * 0.012), // Responsive spacing
              Text(
                content?.title ?? "Judul tidak tersedia",
                style: AppTextStyle.titleLarge.copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: mq.size.height * 0.006), // Responsive spacing
              Text(content?.formattedDate ?? "Tanggal tidak tersedia", style: AppTextStyle.dateText),
              SizedBox(height: mq.size.height * 0.012), // Responsive spacing
              if (content?.authors != null && content!.authors.isNotEmpty) ...[
                for (String author in content!.authors.take(2)) // Show max 2 authors
                  Padding(
                    padding: EdgeInsets.only(bottom: mq.size.height * 0.006),
                    child: AuthorName(
                      img: 'assets/images/example-profile.jpg',
                      name: author,
                    ),
                  ),
              ] else ...[
                const AuthorName(
                  img: 'assets/images/example-profile.jpg',
                  name: "Penulis tidak tersedia",
                ),
              ],
              Divider(height: mq.size.height * 0.036), // Responsive spacing
              // Hide download/read buttons for Video type
              if (content?.type != 'Video') ...[
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.componentColor,
                          minimumSize: Size(mq.size.width * 0.4, 45),
                        ),
                        onPressed: () {},
                        child: Text("Unduh dokumen", style: AppTextStyle.badge),
                      ),
                    ),
                    SizedBox(width: mq.size.width * 0.025), // Responsive spacing
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColor.componentColor),
                          minimumSize: Size(mq.size.width * 0.4, 45),
                        ),
                        onPressed: () {},
                        child: Text("Baca dokumen", style: AppTextStyle.caption.copyWith(
                          color: AppColor.componentColor,
                        )),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: mq.size.height * 0.012), // Responsive spacing
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _action(Icons.bookmark_outline, "Simpan"),
                  _action(Icons.thumb_up_outlined, "Rekomendasi"),
                  _action(Icons.share_outlined, "Bagikan"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text, bool filled) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: filled ? AppColor.componentColor : Colors.white,
        border: Border.all(color: AppColor.componentColor),
      ),
      child: Text(
        text,
        style: AppTextStyle.caption.copyWith(
          color: filled ? Colors.white : AppColor.componentColor,
        ),
      ),
    );
  }

  Widget _action(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 20), // Fixed icon size for now
        const SizedBox(width: 4),
        Text(label, style: AppTextStyle.caption),
      ],
    );
  }
}
