import 'package:flutter/material.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

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
            radius: mq.size.width * 0.1, // Responsive radius
            backgroundColor: AppColor.componentColor,
            child: Icon(
              Icons.camera_alt_outlined, 
              color: AppColor.bgColor, 
              size: mq.size.width * 0.08, // Responsive icon size
            ),
          ),
          SizedBox(height: mq.size.height * 0.018), // Responsive spacing
          Text(
            "Johan Liebert",
            style: AppTextStyle.titleLarge,
          ),
          SizedBox(height: mq.size.height * 0.012), // Responsive spacing
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: AppTextStyle.bodyText,
              children: const [
                TextSpan(text: 'Magister'),
                TextSpan(text: ' | '),
                TextSpan(text: 'Guru di Academy Research Hextech di Piltover'),
                TextSpan(text: ' | '),
              ],
            ),
          ),
          SizedBox(height: mq.size.height * 0.024), // Responsive spacing
        ],
      ),
    );
  }
}
