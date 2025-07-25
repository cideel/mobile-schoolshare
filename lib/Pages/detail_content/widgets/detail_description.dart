import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailDescriptionCard extends StatelessWidget {
  const DetailDescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Deskripsi",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(
                "Merang Mushroom (Volvariella volvaceae) is one of the edible mushrooms. "
                "The nutritional content of merang mushrooms makes this mushroom has potential "
                "as a medicine and food supplement. Merang mushrooms are known to function as antioxidants, "
                "antidiabetic, antiviral, and can lower cholesterol. The purpose of the research is to find out "
                "the nutritional content of merang mushrooms that are cultivated in corncob media with the addition of rice bran...",
                style: TextStyle(fontSize: 15.sp),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
