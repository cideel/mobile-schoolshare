import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class CommentInputWidget extends StatefulWidget {
  final Function(String) onCommentSubmitted;
  final TextEditingController commentController;

  const CommentInputWidget({
    super.key,
    required this.onCommentSubmitted,
    required this.commentController,
  });

  @override
  State<CommentInputWidget> createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends State<CommentInputWidget> {
  void _submitComment() {
    if (widget.commentController.text.trim().isNotEmpty) {
      widget.onCommentSubmitted(widget.commentController.text.trim());
      widget.commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Container(
      padding: EdgeInsets.all(mq.size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Comment Input Field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: TextField(
                controller: widget.commentController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Tulis komentar...",
                  hintStyle: AppTextStyle.bodyText.copyWith(
                    color: Colors.grey[500],
                    fontSize: 14.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: mq.size.width * 0.04,
                    vertical: mq.size.height * 0.015,
                  ),
                ),
                style: AppTextStyle.bodyText.copyWith(fontSize: 14.sp),
                onSubmitted: (_) => _submitComment(),
              ),
            ),
          ),

          SizedBox(width: mq.size.width * 0.025),

          // Send Button
          GestureDetector(
            onTap: _submitComment,
            child: Container(
              padding: EdgeInsets.all(mq.size.width * 0.03),
              decoration: BoxDecoration(
                color: AppColor.componentColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
