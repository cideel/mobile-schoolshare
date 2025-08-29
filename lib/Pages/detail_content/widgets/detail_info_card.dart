import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Config/text_styles.dart';
import 'package:schoolshare/Pages/home/widgets/author_name.dart'; // gunakan ulang komponen AuthorName

class DetailInfoCard extends StatelessWidget {
  const DetailInfoCard({super.key});

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
                  _label("Publikasi", true),
                  SizedBox(width: mq.size.width * 0.02), // Responsive spacing
                  _label("Dokumen tersedia", false),
                ],
              ),
              SizedBox(height: mq.size.height * 0.012), // Responsive spacing
              Text(
                "Proximate Analysis of Merang Mushrooms (Volvariella volvacea) Cultivated on Corncob and Rice Bran Media",
                style: AppTextStyle.titleLarge.copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: mq.size.height * 0.006), // Responsive spacing
              Text("12 Agustus 2023", style: AppTextStyle.dateText),
              SizedBox(height: mq.size.height * 0.012), // Responsive spacing
              const AuthorName(
                img: 'assets/images/example-profile.jpg',
                name: "John Snow",
              ),
              SizedBox(height: mq.size.height * 0.006), // Responsive spacing
              const AuthorName(
                img: 'assets/images/example-profile-2.jpg',
                name: "Ratandi Ahmad Fauzan",
              ),
              Divider(height: mq.size.height * 0.036), // Responsive spacing
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
