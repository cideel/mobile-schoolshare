// lib/features/home/widgets/publication_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Import Get
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/data/models/publication.dart';
import 'package:schoolshare/features/home/controllers/home_controller.dart'; // Import Controller
import 'author_name.dart'; // Asumsi AuthorName adalah widget yang ada

class PublicationItem extends StatelessWidget {
  final Publication publication;
  final VoidCallback? onTap;

  const PublicationItem({
    super.key,
    required this.publication,
    this.onTap,
  });

  String _formatDate(DateTime date) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  ImageProvider _getImageProvider(String url) {
    if (url.isNotEmpty && !url.startsWith('assets/')) {
      final separator = url.startsWith('/') ? '' : '/';
      final fullUrl = ApiUrls.storageUrl + separator + url;
      return NetworkImage(fullUrl);
    }
    return const AssetImage('assets/images/example-profile.jpg');
  }

  // 🔥 WIDGET BARU: Menampilkan sisa kontributor sebagai stack horizontal
  Widget _buildRemainingContributors(
      BuildContext context, List<AuthorModel> remaining, double size) {
    final mq = MediaQuery.of(context);
    if (remaining.isEmpty) return const SizedBox.shrink();

    // Tentukan jumlah yang tersisa
    final int count = remaining.length;
    // Ambil maksimal 3 profil untuk stack
    final List<AuthorModel> profilesToStack = remaining.take(3).toList();

    // Ukuran avatar yang lebih kecil untuk stack horizontal
    final double avatarSize = size * 0.5;

    // List widget untuk profile pictures (stacked)
    final List<Widget> profileStack = [];

    // Tambahkan gambar profil ke stack
    for (int i = 0; i < profilesToStack.length; i++) {
      profileStack.add(
        Positioned(
          left: i * (avatarSize * 0.7), // Overlap sebesar 30%
          child: Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
              image: DecorationImage(
                image: _getImageProvider(profilesToStack[i].profileUrl ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    }

    // Widget Text untuk sisa kontributor (+X) jika ada lebih dari 3
    final Widget remainingText = count > 3
        ? Text(
            '+${count - profilesToStack.length}',
            style: AppTextStyle.caption.copyWith(
              fontSize: 12.sp,
              color: AppColor.componentColor,
              fontWeight: FontWeight.bold,
            ),
          )
        : const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(top: mq.size.height * 0.006),
      child: Row(
        children: [
          // Stack gambar profil
          SizedBox(
            width: profilesToStack.length * (avatarSize * 0.7) +
                (avatarSize * 0.3),
            height: avatarSize,
            child: Stack(
              children: profileStack,
            ),
          ),
          SizedBox(width: mq.size.width * 0.01),
          // Teks sisa kontributor
          remainingText,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final HomeController controller = Get.find<HomeController>();

    final String uploaderImageUrl = publication.uploaderProfileUrl;

    return Obx(() {
      final currentPubIndex =
          controller.publications.indexWhere((p) => p.id == publication.id);
      final currentPub = currentPubIndex != -1
          ? controller.publications[currentPubIndex]
          : publication;

      final bool isBook = currentPub.type.toLowerCase() == 'book';
      final List<AuthorModel> contributors =
          isBook ? currentPub.publishers : currentPub.authors;

      // Ambil 3 kontributor pertama untuk ditampilkan secara vertikal
      final List<AuthorModel> visibleContributors =
          contributors.take(3).toList();

      // Ambil sisanya untuk indikator horizontal
      final List<AuthorModel> remainingContributors =
          contributors.skip(3).toList();

      return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: mq.size.height * 0.02),
          child: Column(
            children: [
              const Divider(thickness: 0.5, color: Colors.grey),
              SizedBox(height: mq.size.height * 0.01),

              // ... (BAGIAN HEADER: UPLOADER/PENULIS UTAMA TIDAK BERUBAH) ...
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: mq.size.width * 0.065,
                      backgroundImage: _getImageProvider(uploaderImageUrl),
                    ),
                    SizedBox(width: mq.size.width * 0.025),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentPub.uploaderName,
                            style: AppTextStyle.cardTitle
                                .copyWith(fontSize: 15.sp),
                          ),
                          Text(
                            currentPub.uploaderInstitutionName,
                            style:
                                AppTextStyle.caption.copyWith(fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: mq.size.height * 0.015),

              // --- BAGIAN KONTEN UTAMA ---
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(color: Colors.grey, width: 0.3),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(mq.size.width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentPub.title,
                          style:
                              AppTextStyle.titleLarge.copyWith(fontSize: 18.sp),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: mq.size.height * 0.008),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.r),
                            color: AppColor.componentColor,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: mq.size.width * 0.015,
                              vertical: mq.size.height * 0.004),
                          child: Text(
                            currentPub.type.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 11),
                          ),
                        ),
                        SizedBox(height: mq.size.height * 0.008),
                        Text(
                          _formatDate(currentPub.publishedDate),
                          style: AppTextStyle.dateText,
                        ),
                        SizedBox(height: mq.size.height * 0.012),

                        // 🔥 Daftar Kontributor YANG TERLIHAT (Maks 3 Vertikal)
                        ...visibleContributors
                            .map(
                              (contributor) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: mq.size.height * 0.006),
                                child: AuthorName(
                                  img: contributor.profileUrl ??
                                      'assets/images/example-profile.jpg',
                                  name: contributor.name,
                                ),
                              ),
                            )
                            .toList(),

                        // 🔥 Indikator Sisa Kontributor (Jika lebih dari 3 total)
                        if (contributors.length > 3)
                          _buildRemainingContributors(
                            context,
                            remainingContributors,
                            mq.size.width *
                                0.065, // Menggunakan ukuran avatar uploader sebagai referensi
                          ),

                        SizedBox(height: mq.size.height * 0.012),

                        // Statistik
                        Row(
                          children: [
                            Text(
                              "${currentPub.readCount} Dibaca",
                              style: AppTextStyle.readCount,
                            ),
                            const Text("  •  "),
                            Text(
                              "${currentPub.likeCount} Rekomendasi",
                              style: AppTextStyle.readCount,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: mq.size.height * 0.015),

              // ... (BAGIAN ACTION ICON TIDAK BERUBAH) ...
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 1. BOOKMARK (Simpan)
                    ActionIcon(
                      icon: currentPub.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      label: "Simpan",
                      color: currentPub.isBookmarked
                          ? AppColor.componentColor
                          : null,
                      onTap: () => controller.toggleBookmark(currentPub),
                    ),
                    // 2. RECOMMEND (Rekomendasi)
                    ActionIcon(
                      icon: currentPub.isRecommended
                          ? Icons.thumb_up
                          : Icons.thumb_up_outlined,
                      label: "Rekomendasi",
                      color: currentPub.isRecommended
                          ? AppColor.componentColor
                          : null,
                      onTap: () => controller.toggleRecommendation(currentPub),
                    ),
                    // 3. SHARE (Bagikan)
                    ActionIcon(
                      icon: Icons.share_outlined,
                      label: "Bagikan",
                      onTap: () => controller.handleShare(currentPub),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1),
            ],
          ),
        ),
      );
    });
  }
}

// ActionIcon (Tidak ada perubahan)
class ActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? color;

  const ActionIcon({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final iconColor = color ?? Colors.grey.shade700;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: mq.size.width * 0.05, color: iconColor),
          SizedBox(width: mq.size.width * 0.01),
          Text(label, style: AppTextStyle.caption.copyWith(color: iconColor)),
        ],
      ),
    );
  }
}
