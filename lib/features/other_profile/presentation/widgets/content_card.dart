import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class ContentCard extends StatelessWidget {
  final String title;
  final String type;
  final List<String> authors;
  final int views;
  final int likes;
  final String date;

  const ContentCard({
    super.key,
    required this.title,
    required this.type,
    required this.authors,
    required this.views,
    required this.likes,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: EdgeInsets.all(mq.size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Content Type Badge and Date
            _buildContentTypeAndCategory(mq),
            
            SizedBox(height: mq.size.height * 0.012),
            
            // Title
            Text(
              title,
              style: AppTextStyle.bodyText.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            SizedBox(height: mq.size.height * 0.012),
            
            // Authors with Circle Avatars
            _buildAuthorsSection(context),
            
            SizedBox(height: mq.size.height * 0.015),
            
            // Stats and Date
            Row(
              children: [
                Icon(
                  Icons.visibility_outlined,
                  size: 16.sp,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: 4.w),
                Text(
                  '$views',
                  style: AppTextStyle.caption.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                
                SizedBox(width: 16.w),
                
                Icon(
                  Icons.favorite_outline,
                  size: 16.sp,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: 4.w),
                Text(
                  '$likes',
                  style: AppTextStyle.caption.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                
                const Spacer(),
                
                Text(
                  date,
                  style: AppTextStyle.caption.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthorsSection(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    if (authors.isEmpty) return const SizedBox.shrink();

    final displayCount = authors.length > 3 ? 3 : authors.length;
    final displayAuthors = authors.take(displayCount).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Penulis:',
          style: AppTextStyle.caption.copyWith(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: mq.size.height * 0.006),
        // Display authors in vertical list (3 rows max)
        ...List.generate(displayAuthors.length, (index) {
          final author = displayAuthors[index];
          return Container(
            margin: EdgeInsets.only(bottom: mq.size.height * 0.006),
            child: _buildSingleAuthorRow(context, author),
          );
        }),
        // Show stacked indicator if there are more than 3 authors
        if (authors.length > 3) 
          Container(
            margin: EdgeInsets.only(bottom: mq.size.height * 0.006),
            child: _buildMoreAuthorsIndicator(context, authors.length - 3),
          ),
      ],
    );
  }

  Widget _buildSingleAuthorRow(BuildContext context, String author) {
    final mq = MediaQuery.of(context);
    
    return Row(
      children: [
        _buildAuthorAvatar(author, mq.size.width * 0.07),
        SizedBox(width: mq.size.width * 0.02),
        Expanded(
          child: Text(
            author,
            style: AppTextStyle.caption.copyWith(
              fontSize: (mq.size.width * 0.03).clamp(11.0, 13.0),
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
              height: 1.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildAuthorAvatar(String authorName, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.componentColor,
        border: Border.all(
          color: AppColor.componentColor.withValues(alpha: 0.8),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          _getInitials(authorName),
          style: AppTextStyle.caption.copyWith(
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildMoreAuthorsIndicator(BuildContext context, int remainingCount) {
    final mq = MediaQuery.of(context);
    
    return Row(
      children: [
        GestureDetector(
          onTap: () => _showAllAuthors(context),
          child: SizedBox(
            width: mq.size.width * 0.1,
            height: mq.size.width * 0.07,
            child: Stack(
              children: [
                // First background circle (furthest back)
                Positioned(
                  left: 0,
                  child: Container(
                    width: mq.size.width * 0.07,
                    height: mq.size.width * 0.07,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.componentColor.withValues(alpha: 0.7),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                // Second circle with counter (front)
                Positioned(
                  left: mq.size.width * 0.025,
                  child: Container(
                    width: mq.size.width * 0.07,
                    height: mq.size.width * 0.07,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.componentColor,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '+$remainingCount',
                        style: AppTextStyle.caption.copyWith(
                          fontSize: (mq.size.width * 0.02).clamp(7.0, 9.0),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: mq.size.width * 0.02),
        Text(
          'Lihat semua penulis',
          style: AppTextStyle.caption.copyWith(
            color: AppColor.componentColor,
            fontWeight: FontWeight.w500,
            fontSize: (mq.size.width * 0.03).clamp(11.0, 13.0),
          ),
        ),
      ],
    );
  }

  String _getInitials(String name) {
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (words.isNotEmpty) {
      return words[0][0].toUpperCase();
    }
    return 'A';
  }

  Widget _buildContentTypeAndCategory(MediaQueryData mq) {
    return Row(
      children: [
        // Content Type Badge
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 4.h,
          ),
          decoration: BoxDecoration(
            color: AppColor.componentColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            type,
            style: AppTextStyle.caption.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        
        const Spacer(),
        
        // Published date
        Text(
          date,
          style: AppTextStyle.caption.copyWith(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  void _showAllAuthors(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Semua Penulis',
            style: AppTextStyle.titleLarge.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: authors.length,
              itemBuilder: (context, index) {
                final author = authors[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      _buildAuthorAvatar(author, 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          author,
                          style: AppTextStyle.caption.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Tutup',
                style: TextStyle(
                  color: AppColor.componentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    );
  }
}
