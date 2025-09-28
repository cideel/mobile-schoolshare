import 'package:flutter/material.dart';
import '../../../core/constants/color.dart';
import '../../../core/constants/text_styles.dart';
import 'author_avatar.dart';

class BookmarkAuthorsList extends StatelessWidget {
  final List<String> authors;
  final double avatarSize;

  const BookmarkAuthorsList({
    super.key,
    required this.authors,
    this.avatarSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
          authors.length > 3 ? 3 : authors.length,
          (index) => _SingleAuthorRow(
            author: authors[index],
            avatarSize: avatarSize,
          ),
        ),
        if (authors.length > 3) 
          _MoreAuthorsIndicator(
            authors: authors,
            remainingCount: authors.length - 3,
            avatarSize: avatarSize,
          ),
      ],
    );
  }
}

class _SingleAuthorRow extends StatelessWidget {
  final String author;
  final double avatarSize;

  const _SingleAuthorRow({
    required this.author,
    required this.avatarSize,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Padding(
      padding: EdgeInsets.only(bottom: mq.size.height * 0.008),
      child: Row(
        children: [
          AuthorAvatar(
            authorName: author,
            size: avatarSize,
          ),
          SizedBox(width: mq.size.width * 0.025),
          Expanded(
            child: GestureDetector(
              onTap: () => _showAuthorFullName(context, author),
              child: Text(
                author,
                style: AppTextStyle.authorName.copyWith(
                  fontSize: mq.size.width * 0.035,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAuthorFullName(BuildContext context, String author) {
    final mq = MediaQuery.of(context);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Nama Lengkap Penulis',
          style: AppTextStyle.sectionTitle.copyWith(
            fontSize: mq.size.width * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          author,
          style: AppTextStyle.bodyText.copyWith(
            fontSize: mq.size.width * 0.038,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Tutup',
              style: TextStyle(
                color: AppColor.componentColor,
                fontSize: mq.size.width * 0.035,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoreAuthorsIndicator extends StatelessWidget {
  final List<String> authors;
  final int remainingCount;
  final double avatarSize;

  const _MoreAuthorsIndicator({
    required this.authors,
    required this.remainingCount,
    required this.avatarSize,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Padding(
      padding: EdgeInsets.only(bottom: mq.size.height * 0.008),
      child: GestureDetector(
        onTap: () => _showAllAuthors(context),
        child: _AuthorStack(
          remainingCount: remainingCount,
          avatarSize: avatarSize,
        ),
      ),
    );
  }

  void _showAllAuthors(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Semua Penulis',
          style: AppTextStyle.sectionTitle.copyWith(
            fontSize: mq.size.width * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: authors.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: mq.size.height * 0.005),
                child: Text(
                  '${index + 1}. ${authors[index]}',
                  style: AppTextStyle.bodyText.copyWith(
                    fontSize: mq.size.width * 0.035,
                  ),
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
                fontSize: mq.size.width * 0.035,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthorStack extends StatelessWidget {
  final int remainingCount;
  final double avatarSize;

  const _AuthorStack({
    required this.remainingCount,
    required this.avatarSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            color: AppColor.componentColor.withOpacity(0.7),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
        ),
        Positioned(
          left: avatarSize * 0.3,
          child: Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              color: AppColor.componentColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Center(
              child: Text(
                '+$remainingCount',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: avatarSize * 0.3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
