import 'package:flutter/material.dart';
import '../../../../core/constants/text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String title;
  final String? imageAsset; // Bisa URL atau lokal
  final String? initials; // Optional, jika foto tidak ada

  const ProfileHeader({
    super.key,
    required this.name,
    required this.title,
    this.imageAsset,
    this.initials,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final bool isNetwork = imageAsset != null && imageAsset!.startsWith('http');

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: mq.size.width * 0.05,
        vertical: mq.size.height * 0.015,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: mq.size.width * 0.10,
            backgroundColor: Colors.blue.shade600,
            backgroundImage: isNetwork
                ? NetworkImage(imageAsset!)
                : (imageAsset != null
                    ? AssetImage(imageAsset!) as ImageProvider
                    : null),
            child: (imageAsset == null || imageAsset!.isEmpty)
                ? Text(
                    initials ?? name.characters.first.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  )
                : null,
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
