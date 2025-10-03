// detail_info_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/data/models/publication.dart';
import 'package:schoolshare/features/detail_content/presentation/controllers/detail_content_controller.dart';
import 'package:schoolshare/features/home/presentation/widgets/author_name.dart';

class DetailInfoCard extends StatelessWidget {
  final Publication publication;
  final DetailContentController controller;

  const DetailInfoCard({
    super.key,
    required this.publication,
    required this.controller,
  });

  // Helper method untuk menampilkan daftar penulis dan uploader
  List<Widget> _buildCombinedEntities(BuildContext context) {
    final mq = MediaQuery.of(context);
    final pub = publication;

    final pubType = pub.type.toLowerCase();

    // Tipe 'peraturan' tidak memiliki authors yang ditampilkan sebagai penulis
    final bool isRegulation = pubType == 'peraturan';

    // 1. Tentukan daftar entitas utama (hanya Penulis, kecuali Peraturan)
    final List<AuthorModel> primaryAuthors =
        (!isRegulation && pub.authors.isNotEmpty) ? pub.authors : [];

    // 2. Buat daftar widget dari entitas utama (Penulis)
    List<Widget> entityWidgets = primaryAuthors
        .map((author) => Padding(
              padding: EdgeInsets.only(bottom: mq.size.height * 0.006),
              child: AuthorName(
                img: author.profileUrl.toString(),
                name: author.name.toString(),
              ),
            ))
        .toList();

    // 3. Tambahkan Uploader jika namanya tidak ada di daftar Penulis utama
    bool uploaderIsPrimary =
        primaryAuthors.any((author) => author.name == pub.uploaderName);

    if (pub.uploaderName.isNotEmpty && !uploaderIsPrimary) {
      entityWidgets.add(
        Padding(
          padding: EdgeInsets.only(bottom: mq.size.height * 0.006),
          child: AuthorName(
            img: pub.uploaderProfileUrl.toString(),
            name: pub.uploaderName.toString(),
          ),
        ),
      );
    }

    return entityWidgets;
  }

  // 🔥 Fungsi untuk menentukan teks status ketersediaan (Menggunakan filePath)
  String get _availabilityStatusText {
    final type = publication.type.toLowerCase();

    if (type == 'video') {
      // Untuk video, cek videoUrl
      return publication.videoUrl.isNotEmpty
          ? 'Video tersedia'
          : 'Video tidak tersedia';
    } else {
      // Untuk dokumen, cek filePath (PERUBAHAN!)
      return publication.filePath.isNotEmpty
          ? 'Dokumen tersedia'
          : 'Dokumen tidak tersedia';
    }
  }

  // 🔥 Fungsi untuk menentukan status ketersediaan file (Menggunakan filePath)
  bool get _isFileAvailable {
    final type = publication.type.toLowerCase();

    if (type == 'video') {
      return publication.videoUrl.isNotEmpty;
    } else {
      // Cek filePath (PERUBAHAN!)
      return publication.filePath.isNotEmpty;
    }
  }

  // Fungsi untuk menentukan apakah tombol unduh/baca harus ditampilkan
  bool get _shouldShowDocumentActions {
    return publication.type.toLowerCase() != 'video';
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final pub = publication;

    final List<Widget> combinedEntities = _buildCombinedEntities(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(mq.size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _label(pub.type.capitalizeFirst ?? "Dokumen", true),
                  SizedBox(width: mq.size.width * 0.02),
                  // Menggunakan helper function yang sudah diupdate
                  _label(_availabilityStatusText, _isFileAvailable),
                ],
              ),
              SizedBox(height: mq.size.height * 0.012),
              Text(
                pub.title,
                style: AppTextStyle.titleLarge.copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: mq.size.height * 0.006),
              Text(pub.formattedPublishedDate, style: AppTextStyle.dateText),

              Divider(height: mq.size.height * 0.036),

              // Tampilkan daftar gabungan entitas (Penulis/Uploader)
              ...combinedEntities,

              // Hanya tambahkan Divider jika ada entitas yang ditampilkan
              if (combinedEntities.isNotEmpty)
                Divider(height: mq.size.height * 0.036),

              // Tombol Aksi Dokumen (HANYA TAMPIL JIKA BUKAN VIDEO)
              if (_shouldShowDocumentActions)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.componentColor,
                          minimumSize: Size(mq.size.width * 0.4, 45),
                        ),
                        // ✅ PERUBAHAN: Cek ketersediaan file menggunakan filePath
                        onPressed: pub.filePath.isNotEmpty
                            ? () => controller.handleDownload()
                            : null,
                        child: Text(
                          "Unduh dokumen",
                          style: AppTextStyle.badge,
                        ),
                      ),
                    ),
                    SizedBox(width: mq.size.width * 0.025),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColor.componentColor),
                          minimumSize: Size(mq.size.width * 0.4, 45),
                        ),
                        // ✅ PERUBAHAN: Cek ketersediaan file menggunakan filePath
                        onPressed: pub.filePath.isNotEmpty
                            ? () {
                                Get.snackbar('Aksi', 'Membuka dokumen...',
                                    snackPosition: SnackPosition.TOP);
                              }
                            : null,
                        child: Text(
                          "Baca dokumen",
                          style: AppTextStyle.caption.copyWith(
                            color: AppColor.componentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              SizedBox(height: mq.size.height * 0.012),

              // Aksi Metrik Dinamis
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _action(
                    icon: pub.isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                    label: "Simpan",
                    onTap: () => controller.toggleBookmark(),
                    color: pub.isBookmarked
                        ? AppColor.componentColor
                        : Colors.grey.shade700,
                  ),
                  _action(
                    icon: pub.isRecommended
                        ? Icons.thumb_up
                        : Icons.thumb_up_outlined,
                    label: "Rekomendasi",
                    onTap: () => controller.toggleRecommendation(),
                    color: pub.isRecommended
                        ? AppColor.componentColor
                        : Colors.grey.shade700,
                  ),
                  _action(
                    icon: Icons.share_outlined,
                    label: "Bagikan",
                    onTap: () => controller.handleShare(),
                    color: Colors.grey.shade700,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ... (Widget _label dan _action tetap sama)
  Widget _label(String text, bool filled) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: filled ? AppColor.componentColor : Colors.white,
        border: Border.all(color: AppColor.componentColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: AppTextStyle.caption.copyWith(
          color: filled ? Colors.white : AppColor.componentColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _action({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20.w, color: color),
          SizedBox(width: 4.w),
          Text(label, style: AppTextStyle.caption.copyWith(color: color)),
        ],
      ),
    );
  }
}
