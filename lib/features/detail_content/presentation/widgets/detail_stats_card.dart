// detail_stats_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/data/models/publication.dart';

class DetailStatsCard extends StatelessWidget {
  final Publication publication;
  const DetailStatsCard({super.key, required this.publication});

  // Helper method untuk menentukan label metrik baca/lihat
  String get _readMetricLabel {
    // Cek apakah tipenya adalah 'video' (case-insensitive)
    if (publication.type.toLowerCase() == 'video') {
      return 'Dilihat';
    } else {
      return 'Dibaca';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    // 🔥 Menggunakan helper method untuk mendapatkan label yang benar
    final readLabel = _readMetricLabel;

    final stats = {
      "Rekomendasi": publication.likeCount,
      // 🔥 Menggunakan label dinamis
      readLabel: publication.readCount, 
      "Diunduh": publication.downloadCount,
      "Dibagikan": publication.shareCount, 
    };

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(mq.size.width * 0.04),
          child: Column(
            // Menggunakan .entries.map untuk membangun daftar baris stat
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