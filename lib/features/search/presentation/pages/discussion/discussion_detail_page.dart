import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/data/models/discussion_item.dart';
import '../../widgets/discussion_widgets/discussion_header.dart';
import '../../widgets/discussion_widgets/comment_card.dart';
import '../../widgets/discussion_widgets/comment_input_widget.dart';

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
    _comments = [
      CommentItem(
        id: '1',
        content: 'Pertanyaan yang sangat menarik! Menurut saya, optimasi performa motor vario sangat kencang',
        author: 'Dr. Sarah Wilson',
        authorPhoto: 'assets/images/example-profile-2.jpg',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        replies: [
          CommentItem(
            id: '1_1',
            content: 'Saya setuju dengan Dr. Sarah. Pengalaman saya juga menunjukkan hal yang sama.',
            author: 'Ahmad Fauzan',
            authorPhoto: 'assets/images/example-profile.jpg',
            createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
          ),
          CommentItem(
            id: '1_2',
            content: 'Terima kasih atas insightnya! Sangat membantu.',
            author: 'Maria Santos',
            authorPhoto: 'assets/images/example-profile-2.jpg',
            createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
          ),
        ],
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
        replies: [
          CommentItem(
            id: '3_1',
            content: 'Betul sekali! Tips yang sangat berguna.',
            author: 'Dr. Sarah Wilson',
            authorPhoto: 'assets/images/example-profile-2.jpg',
            createdAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
          ),
        ],
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
                  DiscussionHeader(discussion: widget.discussion),

                  SizedBox(height: mq.size.height * 0.03),

                  Container(
                    margin: EdgeInsets.only(top: mq.size.height * 0.01),
                    child: Text(
                      'Diskusi (${_comments.length})',
                      style: AppTextStyle.bodyText.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: mq.size.height * 0.02),

                  ..._comments.map((comment) => CommentCard(
                    comment: comment,
                    onReplySubmitted: _addReply,
                    nestingLevel: 0,
                  )),
                ],
              ),
            ),
          ),

          // Comment Input
          CommentInputWidget(
            commentController: _commentController,
            onCommentSubmitted: (content) => _addComment(content),
          ),
        ],
      ),
    );
  }

  void _addComment(String content) {
    if (content.trim().isNotEmpty) {
      setState(() {
        _comments.insert(
          0,
          CommentItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            content: content.trim(),
            author: 'Kamu', 
            authorPhoto: 'assets/images/example-profile.jpg',
            createdAt: DateTime.now(),
          ),
        );
      });
    }
  }

  void _addReply(String parentCommentId, String replyContent) {
    if (replyContent.trim().isEmpty) return;
    
    try {
      setState(() {
        final newReply = CommentItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: replyContent.trim(),
          author: 'Kamu', 
          authorPhoto: 'assets/images/example-profile.jpg',
          createdAt: DateTime.now(),
        );

        final updatedComments = <CommentItem>[];
        
        for (final comment in _comments) {
          if (comment.id == parentCommentId) {
            final updatedReplies = List<CommentItem>.from(comment.replies ?? []);
            updatedReplies.insert(0, newReply);
            updatedComments.add(comment.copyWith(replies: updatedReplies));
          } else {
            bool foundInReplies = false;
            if (comment.replies != null) {
              final updatedReplies = <CommentItem>[];
              for (final reply in comment.replies!) {
                if (reply.id == parentCommentId) {
                  final nestedReplies = List<CommentItem>.from(reply.replies ?? []);
                  nestedReplies.insert(0, newReply);
                  updatedReplies.add(reply.copyWith(replies: nestedReplies));
                  foundInReplies = true;
                } else {
                  updatedReplies.add(reply);
                }
              }
              if (foundInReplies) {
                updatedComments.add(comment.copyWith(replies: updatedReplies));
              } else {
                updatedComments.add(comment);
              }
            } else {
              updatedComments.add(comment);
            }
          }
        }
        
        _comments = updatedComments;
      });
      
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menambahkan balasan: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
      debugPrint('Error in _addReply: $e');
    }
  }
}
