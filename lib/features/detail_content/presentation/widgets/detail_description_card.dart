import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class DetailDescriptionCard extends StatelessWidget {
  const DetailDescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(mq.size.width * 0.04), // Responsive padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Deskripsi",
                  style: AppTextStyle.sectionTitle.copyWith(fontSize: 16.sp)),
              SizedBox(height: mq.size.height * 0.012), // Responsive spacing
              Text(
                "Merang Mushroom (Volvariella volvaceae) is one of the edible mushrooms. "
                "The nutritional content of merang mushrooms makes this mushroom has potential "
                "as a medicine and food supplement. Merang mushrooms are known to function as antioxidants, "
                "antidiabetic, antiviral, and can lower cholesterol. The purpose of the research is to find out "
                "the nutritional content of merang mushrooms that are cultivated in corncob media with the addition of rice bran...",
                style: AppTextStyle.bodyText.copyWith(fontSize: 15.sp),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: mq.size.height * 0.036), // Responsive spacing
            ],
          ),
        ),
      ),
    );
  }
}
