import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/models/models.dart';

class CommentCard extends StatefulWidget {
  final CommentItem comment;
  final Function(String, String)? onReplySubmitted; // (parentCommentId, replyContent)
  final int nestingLevel; // For limiting nesting depth

  const CommentCard({
    super.key,
    required this.comment,
    this.onReplySubmitted,
    this.nestingLevel = 0,
  });

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool _isReplying = false;
  final _replyController = TextEditingController();
  final _replyFocusNode = FocusNode();

  @override
  void dispose() {
    _replyController.dispose();
    _replyFocusNode.dispose();
    super.dispose();
  }

  void _toggleReply() {
    setState(() {
      _isReplying = !_isReplying;
      if (_isReplying) {
        // Auto-focus when opening reply
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _replyFocusNode.requestFocus();
        });
      } else {
        _replyController.clear();
      }
    });
  }

  void _submitReply() {
    if (_replyController.text.trim().isNotEmpty && widget.onReplySubmitted != null) {
      try {
        widget.onReplySubmitted!(widget.comment.id, _replyController.text.trim());
        _replyController.clear();
        setState(() {
          _isReplying = false;
        });
        
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Balasan berhasil ditambahkan!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        // Handle error gracefully
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal mengirim balasan: ${e.toString()}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Container(
      margin: EdgeInsets.only(
        bottom: mq.size.height * 0.01,
        left: widget.nestingLevel > 0 ? mq.size.width * 0.08 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main comment card
          Container(
            padding: EdgeInsets.all(mq.size.width * 0.04),
            decoration: BoxDecoration(
              color: widget.nestingLevel > 0 ? Colors.grey[100] : Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: widget.nestingLevel > 0 ? Colors.grey[300]! : Colors.grey[200]!, 
                width: 1
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Author Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: mq.size.width * 0.03,
                      backgroundImage: AssetImage(widget.comment.authorPhoto),
                    ),
                    SizedBox(width: mq.size.width * 0.025),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.comment.author,
                            style: AppTextStyle.authorName.copyWith(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            _getTimeAgo(widget.comment.createdAt),
                            style: AppTextStyle.caption.copyWith(
                              fontSize: 11.sp,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: mq.size.height * 0.01),

                // Comment Content
                Text(
                  widget.comment.content,
                  style: AppTextStyle.bodyText.copyWith(fontSize: 14.sp),
                ),

                SizedBox(height: mq.size.height * 0.012),

                // Reply button (only show if nesting level < 2 and callback is provided)
                if (widget.nestingLevel < 2 && widget.onReplySubmitted != null)
                  Container(
                    margin: EdgeInsets.only(top: mq.size.height * 0.005),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _toggleReply,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: mq.size.width * 0.04,
                              vertical: mq.size.height * 0.008,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.blue.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.reply,
                                  size: 16.sp,
                                  color: Colors.blue[600],
                                ),
                                SizedBox(width: mq.size.width * 0.015),
                                Text(
                                  'Balas',
                                  style: AppTextStyle.caption.copyWith(
                                    fontSize: 12.sp,
                                    color: Colors.blue[600],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Reply input field (only show when replying)
          if (_isReplying)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(
                top: 8,
                left: widget.nestingLevel > 0 ? 16 : 0,
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: AppColor.componentColor.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _replyController,
                    focusNode: _replyFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Balas ${widget.comment.author}...',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 4,
                      ),
                    ),
                    style: const TextStyle(fontSize: 14),
                    maxLines: 3,
                    minLines: 1,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: _toggleReply,
                        style: TextButton.styleFrom(
                          minimumSize: const Size(50, 32),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                        ),
                        child: Text(
                          'Batal',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _submitReply,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.componentColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(60, 32),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Kirim',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Replies
          if (widget.comment.replies != null && widget.comment.replies!.isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: mq.size.height * 0.01),
              child: Column(
                children: widget.comment.replies!.map((reply) {
                  return CommentCard(
                    comment: reply,
                    onReplySubmitted: widget.onReplySubmitted,
                    nestingLevel: widget.nestingLevel + 1,
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} hari lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit lalu';
    } else {
      return 'Baru saja';
    }
  }
}