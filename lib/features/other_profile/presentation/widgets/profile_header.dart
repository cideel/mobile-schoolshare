import 'package:flutter/material.dart';
import '../../../../core/constants/text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String title;
  final String imageAsset;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.title,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: mq.size.width * 0.05,
        vertical: mq.size.height * 0.015, // Dikecilkan dari 0.02 ke 0.015
      ),
      
      child: Column(
        children: [
          CircleAvatar(
            radius: mq.size.width * 0.10,
            backgroundImage: AssetImage(imageAsset),
          ),
          SizedBox(height: mq.size.height * 0.012), 
          Text(
            textAlign: TextAlign.center,
            name,
            style: AppTextStyle.titleLarge.copyWith(
              fontSize: AppTextStyle.titleLarge.fontSize! * 0.9, 
            ),
          ),
          SizedBox(height: mq.size.height * 0.008), 
          Text(
            title,
            style: AppTextStyle.subtitle.copyWith(
              fontSize: AppTextStyle.subtitle.fontSize! * 0.9, 
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: mq.size.height * 0.006), 
          
        ],
      ),
    );
  }
}
