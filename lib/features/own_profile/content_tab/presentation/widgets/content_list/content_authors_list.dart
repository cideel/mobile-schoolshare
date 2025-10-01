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
            CircleAvatar(
              radius: mediaQuery.size.width * 0.035, 
              backgroundColor: AppColor.componentColor,
              child: Icon(
                Icons.person,
                size: mediaQuery.size.width * 0.04,
                color: Colors.white,
              ),
            ),
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
}
