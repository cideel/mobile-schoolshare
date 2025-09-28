import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class DetailDescriptionCard extends StatelessWidget {
  final String description;
  const DetailDescriptionCard({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(mq.size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Deskripsi",
                  style: AppTextStyle.sectionTitle.copyWith(fontSize: 16.sp)),
              SizedBox(height: mq.size.height * 0.012),
              Text(
                description,
                style: AppTextStyle.bodyText.copyWith(fontSize: 15.sp),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: mq.size.height * 0.036),
            ],
          ),
        ),
      ),
    );
  }
}
