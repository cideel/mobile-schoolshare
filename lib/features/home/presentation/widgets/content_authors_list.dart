import 'package:flutter/material.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/text_styles.dart';
import 'content_author_avatar.dart';

class ContentAuthorsList extends StatelessWidget {
  final List<String> authors;

  const ContentAuthorsList({
    super.key,
    required this.authors,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    if (authors.isEmpty) return const SizedBox.shrink();

    final displayCount = authors.length > 3 ? 3 : authors.length;
    final displayAuthors = authors.take(displayCount).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display authors in vertical list (3 rows max)
        ...List.generate(displayAuthors.length, (index) {
          final author = displayAuthors[index];
          return Container(
            margin: EdgeInsets.only(bottom: mq.size.height * 0.008),
            child: _SingleAuthorRow(author: author),
          );
        }),
        // Show stacked indicator if there are more than 3 authors
        if (authors.length > 3) 
          Container(
            margin: EdgeInsets.only(bottom: mq.size.height * 0.008),
            child: _MoreAuthorsIndicator(
              authors: authors,
              remainingCount: authors.length - 3,
            ),
          ),
      ],
    );
  }
}

class _SingleAuthorRow extends StatelessWidget {
  final String author;

  const _SingleAuthorRow({required this.author});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Row(
      children: [
        ContentAuthorAvatar(
          authorName: author,
          size: mq.size.width * 0.07,
        ),
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
}

class _MoreAuthorsIndicator extends StatelessWidget {
  final List<String> authors;
  final int remainingCount;

  const _MoreAuthorsIndicator({
    required this.authors,
    required this.remainingCount,
  });

  @override
  Widget build(BuildContext context) {
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
                      color: AppColor.componentColor.withOpacity(0.7),
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
        const Expanded(child: SizedBox()),
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
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.componentColor.withValues(alpha: 0.1),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColor.componentColor,
                            ),
                          ),
                        ),
                      ),
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
