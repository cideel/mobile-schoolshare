// lib/features/own_profile/update_profile/presentation/widgets/profile_photo_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/features/own_profile/update_profile/presentation/controllers/update_profile_controller.dart';
import 'package:schoolshare/core/services/api_urls.dart';

class ProfilePhotoWidget extends StatelessWidget {
  final UpdateProfileController controller;

  const ProfilePhotoWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Profile Photo
          GestureDetector(
            onTap: controller.showImagePickerBottomSheet,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: _buildProfileImage(),
              ),
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Change Photo Button
          GestureDetector(
            onTap: controller.showImagePickerBottomSheet,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.blue[200]!,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.camera_alt,
                    size: 16.sp,
                    color: Colors.blue[600],
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Ubah Foto',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
      final imageUrl = controller.currentProfilePhotoUrl.startsWith('http')
          ? controller.currentProfilePhotoUrl
          : '${ApiUrls.storageUrl}/${controller.currentProfilePhotoUrl}';

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
          return _buildDefaultAvatar();
        },
      );
    }

    // Priority 3: Default avatar
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
