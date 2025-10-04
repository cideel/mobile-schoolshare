import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/features/own_profile/controllers/header_profile_controller.dart';

class ContentAuthorsList extends StatelessWidget {
  final List<String> authors;
  final MediaQueryData mediaQuery;

  const ContentAuthorsList({
    super.key,
    required this.authors,
    required this.mediaQuery,
  });

  @override
  Widget build(BuildContext context) {
    
    
    if (authors.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Always show first 3 authors in list format
          _buildAuthorList(),
          SizedBox(height: mediaQuery.size.height * 0.015),
        ],
      ),
    );
  }

  // Original list layout - show all authors
  Widget _buildAuthorList() {
    final displayCount = authors.length;
    
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ..._buildAuthorRows(authors.take(displayCount).toList()),
        ],
      ),
    );
  }

  List<Widget> _buildAuthorRows(List<String> authors) {
    final displayCount = authors.length;
    
    return List.generate(displayCount, (index) {
      final author = authors[index];
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: mediaQuery.size.height * 0.01),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Profile avatar dengan foto profil asli jika tersedia
            _buildAuthorAvatar(author),
            SizedBox(width: mediaQuery.size.width * 0.02), 
            Expanded(
              child: Text(
                author,
                style: AppTextStyle.caption.copyWith(
                  fontSize: 12.sp, 
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAuthorAvatar(String authorName) {
    try {
      // Coba ambil header profile controller untuk mendapatkan data profil user
      final headerController = Get.find<HeaderProfileController>();
      final userData = headerController.userProfile.value;
      final currentUserName = userData['name'] ?? '';
      final profileImageUrl = userData['profile'] ?? '';
      
      // Jika author adalah user yang sedang login dan punya foto profil
      if (authorName == currentUserName && profileImageUrl.isNotEmpty) {
        final fullImageUrl = profileImageUrl.startsWith('http')
            ? profileImageUrl
            : '${ApiUrls.storageUrl}/$profileImageUrl?v=${DateTime.now().millisecondsSinceEpoch}';
            
        return CircleAvatar(
          radius: mediaQuery.size.width * 0.035,
          backgroundColor: AppColor.componentColor,
          backgroundImage: NetworkImage(fullImageUrl),
          onBackgroundImageError: (exception, stackTrace) {
            // Fallback ke icon default jika gambar gagal load
            print('Error loading profile image: $exception');
          },
          child: null, // Tidak ada child jika backgroundImage tersedia
        );
      }
    } catch (e) {
      // Header controller tidak tersedia, gunakan avatar default
      print('Header controller not available: $e');
    }
    
    // Default avatar untuk author lain atau jika tidak ada foto profil
    return CircleAvatar(
      radius: mediaQuery.size.width * 0.035, 
      backgroundColor: AppColor.componentColor,
      child: Icon(
        Icons.person,
        size: mediaQuery.size.width * 0.04,
        color: Colors.white,
      ),
    );
  }
}
