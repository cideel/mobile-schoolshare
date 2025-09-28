import 'package:flutter/material.dart';
import '../../../core/constants/color.dart';
import '../../../core/constants/text_styles.dart';

class BookmarkLoadingState extends StatelessWidget {
  const BookmarkLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: mq.size.width * 0.15,
            height: mq.size.width * 0.15,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.componentColor),
            ),
          ),
          SizedBox(height: mq.size.height * 0.02),
          Text(
            'Memuat bookmark...',
            style: AppTextStyle.bodyText.copyWith(
              fontSize: mq.size.width * 0.038,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
