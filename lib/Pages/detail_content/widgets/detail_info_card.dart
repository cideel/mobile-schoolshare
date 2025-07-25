import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
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
                  const SizedBox(width: 8),
                  _label("Dokumen tersedia", false),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Proximate Analysis of Merang Mushrooms...",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text("12 Agustus 2023", style: TextStyle(fontSize: 12.sp)),
              const SizedBox(height: 10),
              const AuthorName(
                img: 'assets/images/example-profile.jpg',
                name: "John Snow",
              ),
              SizedBox(height: 5),
              const AuthorName(
                img: 'assets/images/example-profile-2.jpg',
                name: "Ratandi Ahmad Fauzan",
              ),
              const Divider(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _action(Icons.bookmark_outline, "Simpan"),
                  _action(Icons.thumb_up_outlined, "Rekomendasi"),
                  _action(Icons.share_outlined, "Bagikan"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.componentColor,
                        minimumSize: Size(mq.size.width * 0.4, 45),
                      ),
                      onPressed: () {},
                      child: const Text("Unduh dokumen", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColor.componentColor),
                        minimumSize: Size(mq.size.width * 0.4, 45),
                      ),
                      onPressed: () {},
                      child: Text("Baca dokumen", style: TextStyle(color: AppColor.componentColor)),
                    ),
                  ),
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
        style: TextStyle(
          color: filled ? Colors.white : AppColor.componentColor,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _action(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }
}
