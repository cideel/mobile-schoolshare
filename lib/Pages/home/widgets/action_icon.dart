// lib/Pages/home/widgets/action_icon.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/text_styles.dart';

class ActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const ActionIcon(
      {super.key, required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          children: [
            Icon(icon, size: mq.size.width * 0.05), // Responsive icon size
            SizedBox(width: mq.size.width * 0.01), // Responsive spacing
            Text(label, style: AppTextStyle.caption),
          ],
        ),
      ),
    );
  }
}
