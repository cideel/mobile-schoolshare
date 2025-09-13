import 'package:flutter/material.dart';
import '../../../../core/constants/text_styles.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.description,
    this.icon = Icons.article_outlined,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(mq.size.width * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: mq.size.width * 0.2,
              color: Colors.grey[400],
            ),
            SizedBox(height: mq.size.height * 0.03),
            Text(
              title,
              style: AppTextStyle.titleLarge.copyWith(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: mq.size.height * 0.015),
            Text(
              description,
              style: AppTextStyle.bodyText.copyWith(
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
