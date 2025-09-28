import 'package:flutter/material.dart';
import '../../../../core/constants/text_styles.dart';

class ContentActionButtons extends StatelessWidget {
  final String contentTitle;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onRecommendTap;
  final VoidCallback? onShareTap;

  const ContentActionButtons({
    super.key,
    required this.contentTitle,
    this.onBookmarkTap,
    this.onRecommendTap,
    this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ActionIcon(
            icon: Icons.bookmark_outline,
            label: "Simpan",
            onTap: onBookmarkTap ?? () => _defaultBookmarkAction(),
          ),
          ActionIcon(
            icon: Icons.thumb_up_outlined,
            label: "Rekomendasi",
            onTap: onRecommendTap ?? () => _defaultRecommendAction(),
          ),
          ActionIcon(
            icon: Icons.share_outlined,
            label: "Bagikan",
            onTap: onShareTap ?? () => _defaultShareAction(),
          ),
        ],
      ),
    );
  }

  void _defaultBookmarkAction() {
    print("Bookmark tapped for: $contentTitle");
  }

  void _defaultRecommendAction() {
    print("Recommend tapped for: $contentTitle");
  }

  void _defaultShareAction() {
    print("Share tapped for: $contentTitle");
  }
}

class ActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const ActionIcon({
    super.key, 
    required this.icon, 
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: mq.size.width * 0.02,
          vertical: mq.size.height * 0.008,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: onTap != null ? Colors.grey.shade50 : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon, 
              size: mq.size.width * 0.045,
              color: Colors.grey.shade600,
            ),
            SizedBox(width: mq.size.width * 0.008),
            Text(
              label, 
              style: AppTextStyle.caption.copyWith(
                fontSize: (mq.size.width * 0.026).clamp(9.0, 11.0),
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
