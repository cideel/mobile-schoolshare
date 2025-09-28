import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/text_styles.dart';

class ContentHeader extends StatelessWidget {
  final List<String> authors;
  final String institutionName;

  const ContentHeader({
    super.key,
    required this.authors,
    required this.institutionName,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
      child: Row(
        children: [
          CircleAvatar(
            radius: mq.size.width * 0.065,
            backgroundImage: const AssetImage("assets/images/example-profile.jpg"),
          ),
          SizedBox(width: mq.size.width * 0.025),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  authors.isNotEmpty ? authors.first : "Penulis Tidak Diketahui",
                  style: AppTextStyle.cardTitle.copyWith(fontSize: 15.sp),
                ),
                if (institutionName.isNotEmpty)
                  Text(
                    institutionName,
                    style: AppTextStyle.caption.copyWith(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
