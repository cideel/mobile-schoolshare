import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/data/models/bookmark_model.dart';
import '../../../core/constants/color.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkCard extends StatelessWidget {
  final Bookmark bookmark;

  const BookmarkCard({
    super.key,
    required this.bookmark,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: mq.size.width * 0.04,
        vertical: mq.size.height * 0.008,
      ),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: Colors.grey, width: 0.3),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              // TODO: Navigate to content detail
            },
            child: Padding(
              padding: EdgeInsets.all(mq.size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type Label di atas kiri
                  Row(
                    children: [
                      _buildTypeChip(context),
                      const Spacer(),
                      // Bookmark remove button
                      IconButton(
                        onPressed: () {
                          // Find bookmark controller and toggle bookmark
                          try {
                            final controller = Get.find<BookmarkController>();
                            controller.toggleBookmark(bookmark.content.id);
                          } catch (e) {
                            Get.snackbar(
                              'Error',
                              'Gagal menghapus bookmark',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        icon: Icon(
                          Icons.bookmark_remove,
                          color: Colors.grey.shade500,
                          size: mq.size.width * 0.05,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: mq.size.height * 0.01),
                  
                  // Title di bawah label
                  Text(
                    bookmark.content.name,
                    style: TextStyle(
                      fontSize: mq.size.width * 0.045,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  SizedBox(height: mq.size.height * 0.015),
                  
                  // Stats Row - 4 statistik
                  Row(
                    children: [
                      _buildStatItem(
                        context,
                        Icons.visibility_outlined,
                        bookmark.content.totalReadings,
                      ),
                      SizedBox(width: mq.size.width * 0.04),
                      _buildStatItem(
                        context,
                        Icons.thumb_up_outlined,
                        bookmark.content.totalRecommendations,
                      ),
                      SizedBox(width: mq.size.width * 0.04),
                      _buildStatItem(
                        context,
                        Icons.download_outlined,
                        _getDownloadCount(),
                      ),
                      SizedBox(width: mq.size.width * 0.04),
                      _buildStatItem(
                        context,
                        Icons.share_outlined,
                        _getShareCount(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeChip(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.componentColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        bookmark.content.type.toUpperCase(),
        style: TextStyle(
          fontSize: mq.size.width * 0.03,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, IconData icon, int count) {
    final mq = MediaQuery.of(context);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: mq.size.width * 0.035,
          color: Colors.grey.shade500,
        ),
        SizedBox(width: mq.size.width * 0.01),
        Text(
          _formatCount(count),
          style: TextStyle(
            fontSize: mq.size.width * 0.03,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  int _getDownloadCount() {
    // TODO: Add download count field to bookmark model
    // For now, return a placeholder value
    return 0;
  }

  int _getShareCount() {
    // TODO: Add share count field to bookmark model  
    // For now, return a placeholder value
    return 0;
  }
}
