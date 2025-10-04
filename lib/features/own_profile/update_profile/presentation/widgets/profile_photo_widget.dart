// lib/features/own_profile/update_profile/presentation/widgets/profile_photo_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/features/own_profile/update_profile/presentation/controllers/update_profile_controller.dart';
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/core/constants/color.dart';

class ProfilePhotoWidget extends StatelessWidget {
  final UpdateProfileController controller;

  const ProfilePhotoWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: controller.showImagePickerBottomSheet,
        child: Stack(
          children: [
            // Profile Photo Container
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColor.componentColor.withOpacity(0.3),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.componentColor.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipOval(
                child: _buildProfileImage(),
              ),
            ),
            
            // Camera Icon Overlay
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColor.componentColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    // Priority 1: New selected image
    if (controller.profilePhotoFile != null) {
      return Image.file(
        controller.profilePhotoFile!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    // Priority 2: Current profile photo from server
    if (controller.currentProfilePhotoUrl.isNotEmpty) {
      // Build URL dengan cache busting untuk memaksa reload gambar terbaru
      final baseUrl = controller.currentProfilePhotoUrl.startsWith('http')
          ? controller.currentProfilePhotoUrl
          : '${ApiUrls.storageUrl}/${controller.currentProfilePhotoUrl}';
      
      final imageUrl = '$baseUrl?v=${DateTime.now().millisecondsSinceEpoch}';

      print('Loading image from URL: $imageUrl');

      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          print('Error loading image: $error');
          return _buildDefaultAvatar();
        },
      );
    }

    // Priority 3: Default avatar
    print('No profile photo URL, showing default avatar. URL: "${controller.currentProfilePhotoUrl}"');
    return _buildDefaultAvatar();
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[200],
      child: Icon(
        Icons.person,
        size: 50.sp,
        color: Colors.grey[400],
      ),
    );
  }
}
