import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColor.componentColor,
            child: Icon(Icons.camera_alt_outlined, color: AppColor.bgColor, size: 32),
          ),
          const SizedBox(height: 15),
          Text(
            "Johan Liebert",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 16.sp),
              children: const [
                TextSpan(text: 'Magister'),
                TextSpan(text: ' | '),
                TextSpan(text: 'Guru di Academy Research Hextech di Piltover'),
                TextSpan(text: ' | '),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
