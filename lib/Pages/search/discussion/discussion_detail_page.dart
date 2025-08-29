import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Config/text_styles.dart';
import '../../../Models/discussion_item.dart';

class DiscussionDetailPage extends StatefulWidget {
  final DiscussionItem discussion;

  const DiscussionDetailPage({
    super.key,
    required this.discussion,
  });

  @override
  State<DiscussionDetailPage> createState() => _DiscussionDetailPageState();
}

class _DiscussionDetailPageState extends State<DiscussionDetailPage> {
  final _commentController = TextEditingController();
  late List<CommentItem> _comments;

  @override
  void initState() {
    super.initState();
    //  dummy comments
    _comments = [
      CommentItem(
        id: '1',
        content: 'Pertanyaan yang sangat menarik! Menurut saya, optimasi performa motor vario sangat kencang',
        author: 'Dr. Sarah Wilson',
        authorPhoto: 'assets/images/example-profile-2.jpg',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      CommentItem(
        id: '2',
        content: 'Saya setuju dengan pendapat di atas. Selain itu, penggunaan const knalpot racing juga sangat membantu mengurangi asap yang tidak perlu.',
        author: 'Ahmad Fauzan',
        authorPhoto: 'assets/images/example-profile.jpg',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      CommentItem(
        id: '3',
        content: 'Jangan lupa juga untuk memperhatikan penggunaan parfum dan deodoran untuk bau keringat yang panjang.',
        author: 'Maria Santos',
        authorPhoto: 'assets/images/example-profile-2.jpg',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Diskusi',
          style: AppTextStyle.cardTitle.copyWith(
            fontSize: 18.sp,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Discussion Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(mq.size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Topic Tag
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: mq.size.width * 0.03,
                      vertical: mq.size.height * 0.006,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.componentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.discussion.topic,
                      style: AppTextStyle.caption.copyWith(
                        color: AppColor.componentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: mq.size.height * 0.015),

                  // Title
                  Text(
                    widget.discussion.title,
                    style: AppTextStyle.titleLarge.copyWith(fontSize: 20.sp),
                  ),

                  SizedBox(height: mq.size.height * 0.012),

                  // Author Info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: mq.size.width * 0.04,
                        backgroundImage: AssetImage(widget.discussion.authorPhoto),
                      ),
                      SizedBox(width: mq.size.width * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.discussion.author,
                              style: AppTextStyle.cardTitle.copyWith(fontSize: 14.sp),
                            ),
                            Text(
                              _getTimeAgo(widget.discussion.createdAt),
                              style: AppTextStyle.caption.copyWith(
                                fontSize: 12.sp,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: mq.size.height * 0.02),

                  // Description
                  Text(
                    widget.discussion.description,
                    style: AppTextStyle.bodyText.copyWith(fontSize: 15.sp),
                    textAlign: TextAlign.justify,
                  ),

                  SizedBox(height: mq.size.height * 0.03),

                  // Comments Section
                  Row(
                    children: [
                      Icon(
                        Icons.comment_outlined,
                        size: mq.size.width * 0.05,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: mq.size.width * 0.02),
                      Text(
                        '${_comments.length} Komentar',
                        style: AppTextStyle.sectionTitle.copyWith(fontSize: 16.sp),
                      ),
                    ],
                  ),

                  SizedBox(height: mq.size.height * 0.02),

                  // Comments List
                  ..._comments.map((comment) => _buildCommentCard(comment, mq)),
                ],
              ),
            ),
          ),

          // Comment Input
          _buildCommentInput(mq),
        ],
      ),
    );
  }

  Widget _buildCommentCard(CommentItem comment, MediaQueryData mq) {
    return Container(
      margin: EdgeInsets.only(bottom: mq.size.height * 0.015),
      padding: EdgeInsets.all(mq.size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Info
          Row(
            children: [
              CircleAvatar(
                radius: mq.size.width * 0.03,
                backgroundImage: AssetImage(comment.authorPhoto),
              ),
              SizedBox(width: mq.size.width * 0.025),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.author,
                      style: AppTextStyle.authorName.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _getTimeAgo(comment.createdAt),
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
            comment.content,
            style: AppTextStyle.bodyText.copyWith(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInput(MediaQueryData mq) {
    return Container(
      padding: EdgeInsets.all(mq.size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _commentController,
                style: AppTextStyle.bodyText,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Tulis komentar...',
                  hintStyle: AppTextStyle.caption,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: AppColor.componentColor),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: mq.size.width * 0.04,
                    vertical: mq.size.height * 0.012,
                  ),
                ),
              ),
            ),
            SizedBox(width: mq.size.width * 0.02),
            GestureDetector(
              onTap: _addComment,
              child: Container(
                padding: EdgeInsets.all(mq.size.width * 0.03),
                decoration: const BoxDecoration(
                  color: AppColor.componentColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: mq.size.width * 0.05,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addComment() {
    if (_commentController.text.trim().isNotEmpty) {
      setState(() {
        _comments.insert(
          0,
          CommentItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            content: _commentController.text.trim(),
            author: 'You', // In real app, get from current user
            authorPhoto: 'assets/images/example-profile.jpg',
            createdAt: DateTime.now(),
          ),
        );
      });
      _commentController.clear();
    }
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
