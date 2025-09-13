import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

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

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildAuthorRows(authors),
            if (authors.length > 4) _buildMoreAuthorsIndicator(authors.length),
          ],
        ),
        SizedBox(height: mediaQuery.size.height * 0.015),
      ],
    );
  }

  List<Widget> _buildAuthorRows(List<String> authors) {
    final displayCount = authors.length > 4 ? 4 : authors.length;
    
    return List.generate(displayCount, (index) {
      final author = authors[index];
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: AppColor.componentColor.withOpacity(0.1),
              child: Text(
                _getInitials(author),
                style: AppTextStyle.caption.copyWith(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.componentColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
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

  Widget _buildMoreAuthorsIndicator(int totalAuthors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
            child: Center(
              child: Text(
                '[..]',
                style: AppTextStyle.caption.copyWith(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '+${totalAuthors - 4} penulis lainnya',
            style: AppTextStyle.caption.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
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
}
