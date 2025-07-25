import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      centerTitle: false,
      expandedHeight: 60,
      backgroundColor: Colors.white,
      title: Text(
        overflow: TextOverflow.ellipsis,
        'Proximate Analysis of Merang Mushrooms (Volvariella volvacea)...',
        style: TextStyle(
          fontSize: 15.sp,
          color: Colors.black,
        ),
      ),
    );
  }
}
