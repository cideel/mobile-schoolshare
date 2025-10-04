import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/features/own_profile/controllers/header_profile_controller.dart';
import 'package:schoolshare/core/services/api_urls.dart'; // Import ApiUrls

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Temukan instance controller yang sudah dibuat oleh binding
    final controller = Get.find<HeaderProfileController>();
    final mq = MediaQuery.of(context);

    // Obx akan mendengarkan perubahan pada isLoading, userProfile, dan errorMessage
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red.shade700),
            ),
          ),
        );
      }

      final userData = controller.userProfile.value;
      final name = userData['name'] ?? 'Nama tidak tersedia';
      final position = userData['position']?['name'] ?? 'Posisi tidak tersedia';
      final institutionCategory =
          userData['institusi']?['kategori'] ?? 'Kategori tidak tersedia';
      final institutionName =
          userData['institusi']?['name'] ?? 'Institusi tidak tersedia';
      final profileImageUrl = userData['profile'];

      // Menggabungkan URL dasar penyimpanan dengan jalur file profil
      // Tambahkan cache busting untuk memaksa reload gambar terbaru
      final fullProfileUrl =
          profileImageUrl != null && profileImageUrl.isNotEmpty
              ? '${ApiUrls.storageUrl}/$profileImageUrl?v=${DateTime.now().millisecondsSinceEpoch}'
              : null;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 Membuat CircleAvatar dapat di-tap untuk mengganti foto profil
            GestureDetector(
              onTap: () => controller.pickAndUploadProfilePicture(),
              child: CircleAvatar(
                radius: mq.size.width * 0.1, // Responsive radius
                backgroundColor: AppColor.componentColor,
                // Tampilkan gambar profil jika URL tersedia, jika tidak tampilkan ikon default
                child: fullProfileUrl != null
                    ? ClipOval(
                        child: Image.network(
                          fullProfileUrl,
                          fit: BoxFit.cover,
                          width:
                              mq.size.width * 0.2, // Ukuran ganda dari radius
                          height: mq.size.width * 0.2,
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback jika gambar gagal dimuat
                            return Icon(
                              Icons.person,
                              color: AppColor.bgColor,
                              size: mq.size.width * 0.08,
                            );
                          },
                        ),
                      )
                    : Icon(
                        Icons.person,
                        color: AppColor.bgColor,
                        size: mq.size.width * 0.08,
                      ),
              ),
            ),
            SizedBox(height: mq.size.height * 0.018), // Responsive spacing
            Text(
              name,
              style: AppTextStyle.titleLarge,
            ),
            SizedBox(height: mq.size.height * 0.012), // Responsive spacing
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: AppTextStyle.bodyText,
                children: [
                  TextSpan(text: position),
                  const TextSpan(text: ' | '),
                  TextSpan(text: '$institutionCategory di $institutionName'),
                ],
              ),
            ),
            SizedBox(height: mq.size.height * 0.024),
          ],
        ),
      );
    });
  }
}
