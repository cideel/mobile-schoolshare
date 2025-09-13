import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import '../../../../../data/models/discussion_item.dart';
import '../../widgets/discussion_widgets/comment_card.dart';
import '../../widgets/discussion_widgets/comment_input_widget.dart';

class DiscussionTestPage extends StatefulWidget {
  const DiscussionTestPage({super.key});

  @override
  State<DiscussionTestPage> createState() => _DiscussionTestPageState();
}

class _DiscussionTestPageState extends State<DiscussionTestPage> {
  final _commentController = TextEditingController();
  late List<CommentItem> _comments;

  @override
  void initState() {
    super.initState();
    // Simple test comments
    _comments = [
      CommentItem(
        id: '1',
        content: 'Ini adalah komentar pertama untuk testing tombol reply.',
        author: 'Test User 1',
        authorPhoto: 'assets/images/example-profile.jpg',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      CommentItem(
        id: '2',
        content: 'Ini adalah komentar kedua yang juga harus punya tombol reply.',
        author: 'Test User 2',
        authorPhoto: 'assets/images/example-profile-2.jpg',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
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
      appBar: AppBar(
        title: Text(
          'Test Tombol Reply',
          style: AppTextStyle.sectionTitle.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          // Test Instructions
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Instruksi Testing:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '1. Setiap komentar harus memiliki tombol "Balas" berwarna biru\n'
                  '2. Klik tombol "Balas" untuk membuka form reply\n'
                  '3. Form reply harus muncul dengan field input dan tombol Kirim/Batal',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),

          // Comments Section
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(mq.size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Test Comments',
                    style: AppTextStyle.sectionTitle.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: mq.size.height * 0.02),

                  // Comments List
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
            author: 'You',
            authorPhoto: 'assets/images/example-profile.jpg',
            createdAt: DateTime.now(),
          ),
        );
      });
    }
  }

  void _addReply(String parentCommentId, String replyContent) {
    if (replyContent.trim().isNotEmpty) {
      setState(() {
        // Find the parent comment and add reply
        final parentIndex = _comments.indexWhere((comment) => comment.id == parentCommentId);
        if (parentIndex != -1) {
          final parentComment = _comments[parentIndex];
          final newReply = CommentItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            content: replyContent.trim(),
            author: 'You',
            authorPhoto: 'assets/images/example-profile.jpg',
            createdAt: DateTime.now(),
          );

          // Create updated parent comment with new reply
          final updatedReplies = List<CommentItem>.from(parentComment.replies ?? []);
          updatedReplies.insert(0, newReply);
          
          final updatedParentComment = CommentItem(
            id: parentComment.id,
            content: parentComment.content,
            author: parentComment.author,
            authorPhoto: parentComment.authorPhoto,
            createdAt: parentComment.createdAt,
            replies: updatedReplies,
          );

          _comments[parentIndex] = updatedParentComment;
        }
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Reply berhasil ditambahkan!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
