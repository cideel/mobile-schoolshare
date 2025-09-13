import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'empty_state_button.dart';

class EmptyStateView extends StatelessWidget {
  final VoidCallback onAddPressed;

  const EmptyStateView({
    super.key,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return ListView(
      children: [
        SizedBox(height: mq.size.height * 0.1),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/icon-add.png",
              height: 70,
              width: 70,
              fit: BoxFit.contain,
              color: Colors.grey,
            ),
            SizedBox(height: mq.size.height * 0.02),
            Text(
              "Masih kosong untuk saat ini",
              maxLines: 1,
              style: AppTextStyle.cardTitle.copyWith(
                fontSize: 16.sp,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: mq.size.height * 0.015),
            Text(
              "Yuk, tambahkan penelitianmu! Biar rekomendasimu makin keren dan kamu makin mudah dikenal di antara rekan-rekanmu!",
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyText.copyWith(
                fontSize: 14.sp,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: mq.size.height * 0.03),
            EmptyStateButton(onPressed: onAddPressed),
          ],
        ),
      ],
    );
  }
}
