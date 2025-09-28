import 'package:flutter/material.dart';
import 'package:schoolshare/models/models.dart';
import 'content_item.dart';

class PublicationItem extends StatelessWidget {
  final Content content;
  final VoidCallback? onTap;
  final int index;

  const PublicationItem({
    super.key,
    required this.content,
    this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ContentItem(
        content: content,
        index: index,
      ),
    );
  }
}
