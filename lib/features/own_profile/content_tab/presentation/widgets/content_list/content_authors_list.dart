import 'package:flutter/material.dart';
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
        _buildAuthorsSection(),
        SizedBox(height: mediaQuery.size.height * 0.015),
      ],
    );
  }

  Widget _buildAuthorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._buildAuthorRows(authors),
        if (authors.length > 3) _buildMoreAuthorsIndicator(authors.length),
      ],
    );
  }

  List<Widget> _buildAuthorRows(List<String> authors) {
    final displayCount = authors.length > 3 ? 3 : authors.length;
    
    return List.generate(displayCount, (index) {
      final author = authors[index];
      return Container(
        margin: EdgeInsets.only(bottom: mediaQuery.size.height * 0.01),
        child: Row(
          children: [
            // Author Avatar
            Container(
              width: mediaQuery.size.width * 0.07,
              height: mediaQuery.size.width * 0.07,
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
                  _getInitials(author),
                  style: AppTextStyle.caption.copyWith(
                    fontSize: (mediaQuery.size.width * 0.025).clamp(9.0, 11.0),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: mediaQuery.size.width * 0.025),
            // Author Name
            Expanded(
              child: Text(
                author,
                style: AppTextStyle.caption.copyWith(
                  fontSize: (mediaQuery.size.width * 0.032).clamp(11.0, 13.0),
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                  height: 1.2,
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
    final remainingCount = totalAuthors - 3;
    
    return Container(
      margin: EdgeInsets.only(bottom: mediaQuery.size.height * 0.01),
      child: Row(
        children: [
          // Stacked Circle Avatar Indicator
          GestureDetector(
            onTap: () => _showAllAuthors(),
            child: SizedBox(
              width: mediaQuery.size.width * 0.1,
              height: mediaQuery.size.width * 0.07,
              child: Stack(
                children: [
                  // First background circle (furthest back)
                  Positioned(
                    left: 0,
                    child: Container(
                      width: mediaQuery.size.width * 0.07,
                      height: mediaQuery.size.width * 0.07,
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
                    left: mediaQuery.size.width * 0.025,
                    child: Container(
                      width: mediaQuery.size.width * 0.07,
                      height: mediaQuery.size.width * 0.07,
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
                            fontSize: (mediaQuery.size.width * 0.02).clamp(7.0, 9.0),
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
          SizedBox(width: mediaQuery.size.width * 0.02),
          Text(
            'Lihat semua penulis',
            style: AppTextStyle.caption.copyWith(
              color: AppColor.componentColor,
              fontWeight: FontWeight.w500,
              fontSize: (mediaQuery.size.width * 0.03).clamp(11.0, 13.0),
            ),
          ),
        ],
      ),
    );
  }

  void _showAllAuthors() {
    // This will be implemented when needed for showing all authors dialog
    // For now, just a placeholder
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
