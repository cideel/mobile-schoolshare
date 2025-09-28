import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/data/models/publication.dart';

class DetailStatsCard extends StatelessWidget {
  final Publication publication;
  const DetailStatsCard({super.key, required this.publication});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final stats = {
      "Rekomendasi": publication.likeCount,
      "Dibaca": publication.readCount,
      "Diunduh":
          publication.downloadCount, // TODO: ganti jika API sudah support
      "Dibagikan": publication.shareCount, // TODO: ganti jika API sudah support
    };

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(mq.size.width * 0.04),
          child: Column(
            children:
                stats.entries.map((e) => _buildRow(e.key, e.value)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, int value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyle.caption),
          Text(value.toString(),
              style:
                  AppTextStyle.caption.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
