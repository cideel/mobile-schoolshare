import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/color.dart';
import '../../../core/constants/text_styles.dart';

class BookmarkEmptyState extends StatelessWidget {
  const BookmarkEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIllustration(mq),
            SizedBox(height: mq.size.height * 0.03),
            _buildTitle(mq),
            SizedBox(height: mq.size.height * 0.015),
            _buildDescription(mq),
            SizedBox(height: mq.size.height * 0.04),
            _buildActionButtons(mq),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustration(MediaQueryData mq) {
    return Container(
      width: mq.size.width * 0.3,
      height: mq.size.width * 0.3,
      decoration: BoxDecoration(
        color: AppColor.componentColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.bookmark_border_rounded,
          size: mq.size.width * 0.15,
          color: AppColor.componentColor.withOpacity(0.6),
        ),
      ),
    );
  }

  Widget _buildTitle(MediaQueryData mq) {
    return Text(
      'Belum Ada Bookmark',
      style: AppTextStyle.titleLarge.copyWith(
        fontSize: mq.size.width * 0.055,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription(MediaQueryData mq) {
    return Text(
      'Anda belum menyimpan konten apapun.\nMulai jelajahi dan simpan konten yang menarik!',
      style: AppTextStyle.bodyText.copyWith(
        fontSize: mq.size.width * 0.038,
        color: Colors.grey.shade600,
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildActionButtons(MediaQueryData mq) {
    return Column(
      children: [
        _buildExploreButton(mq),
        SizedBox(height: mq.size.height * 0.015),
        _buildTipsButton(mq),
      ],
    );
  }

  Widget _buildExploreButton(MediaQueryData mq) {
    return SizedBox(
      width: mq.size.width * 0.6,
      height: mq.size.height * 0.055,
      child: ElevatedButton.icon(
        onPressed: () => _onExplorePressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.componentColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: AppColor.componentColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(
          Icons.explore,
          size: mq.size.width * 0.045,
        ),
        label: Text(
          'Jelajahi Konten',
          style: AppTextStyle.labelStyle.copyWith(
            fontSize: mq.size.width * 0.04,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTipsButton(MediaQueryData mq) {
    return SizedBox(
      width: mq.size.width * 0.6,
      height: mq.size.height * 0.055,
      child: OutlinedButton.icon(
        onPressed: () => _showTipsDialog(),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColor.componentColor,
          side: BorderSide(color: AppColor.componentColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(
          Icons.lightbulb_outline,
          size: mq.size.width * 0.045,
        ),
        label: Text(
          'Tips Bookmark',
          style: AppTextStyle.labelStyle.copyWith(
            fontSize: mq.size.width * 0.04,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _onExplorePressed() {
    // Kembali ke halaman home
    Get.back();
    
    Get.snackbar(
      'Jelajahi Konten',
      'Mari temukan konten menarik untuk disimpan!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.componentColor.withOpacity(0.9),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.explore, color: Colors.white),
    );
  }

  void _showTipsDialog() {
    final mq = MediaQuery.of(Get.context!);
    
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.lightbulb,
              color: AppColor.componentColor,
              size: mq.size.width * 0.06,
            ),
            SizedBox(width: mq.size.width * 0.02),
            Text(
              'Tips Bookmark',
              style: AppTextStyle.sectionTitle.copyWith(
                fontSize: mq.size.width * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTipItem(mq, '📚', 'Tap ikon bookmark di setiap konten untuk menyimpan'),
            _buildTipItem(mq, '🔍', 'Gunakan fitur pencarian untuk menemukan konten spesifik'),
            _buildTipItem(mq, '⭐', 'Bookmark konten berkualitas untuk referensi masa depan'),
            _buildTipItem(mq, '🗂️', 'Kelola bookmark Anda secara berkala'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Mengerti',
              style: TextStyle(
                color: AppColor.componentColor,
                fontSize: mq.size.width * 0.035,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(MediaQueryData mq, String emoji, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: mq.size.height * 0.012),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: TextStyle(fontSize: mq.size.width * 0.04),
          ),
          SizedBox(width: mq.size.width * 0.025),
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.bodyText.copyWith(
                fontSize: mq.size.width * 0.035,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}