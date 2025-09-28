import 'package:flutter/material.dart';
import '../../../core/constants/color.dart';
import '../../../core/constants/text_styles.dart';
import '../../../controllers/bookmark_controller.dart';

class BookmarkErrorState extends StatelessWidget {
  final BookmarkController controller;
  
  const BookmarkErrorState({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: mq.size.width * 0.15,
              color: Colors.red.shade400,
            ),
            SizedBox(height: mq.size.height * 0.02),
            Text(
              'Gagal Memuat Bookmark',
              style: AppTextStyle.sectionTitle.copyWith(
                fontSize: mq.size.width * 0.045,
                fontWeight: FontWeight.w600,
                color: Colors.red.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: mq.size.height * 0.01),
            Text(
              controller.errorMessage.value,
              style: AppTextStyle.bodyText.copyWith(
                fontSize: mq.size.width * 0.035,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: mq.size.height * 0.03),
            _RetryButton(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  final BookmarkController controller;
  
  const _RetryButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return SizedBox(
      width: mq.size.width * 0.5,
      height: mq.size.height * 0.05,
      child: ElevatedButton.icon(
        onPressed: () => controller.loadBookmarks(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.componentColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(Icons.refresh, size: mq.size.width * 0.04),
        label: Text(
          'Coba Lagi',
          style: AppTextStyle.labelStyle.copyWith(
            fontSize: mq.size.width * 0.035,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
