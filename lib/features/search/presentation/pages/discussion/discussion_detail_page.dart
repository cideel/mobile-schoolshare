// lib/features/discussion/presentation/pages/discussion/discussion_detail_page.dart (FINAL FIX)

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/data/models/discussion_item.dart';
import 'package:schoolshare/features/search/presentation/controllers/discussion_detail_controller.dart';
import '../../widgets/discussion_widgets/discussion_header.dart';
import '../../widgets/discussion_widgets/comment_card.dart';
import '../../widgets/discussion_widgets/comment_input_widget.dart';

class DiscussionDetailPage extends StatelessWidget {
  final DiscussionItem discussion;

  const DiscussionDetailPage({
    super.key,
    required this.discussion,
  });

  // Helper untuk menampilkan SnackBar
  void _showSnackbar(BuildContext context, String message,
      {bool isSuccess = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1. Inisialisasi controller dengan ID unik (tag)
    final controller = Get.put(
      DiscussionDetailController(initialDiscussion: discussion),
      tag: discussion.id.toString(),
    );

    final mq = MediaQuery.of(context);

    return GetBuilder<DiscussionDetailController>(
      tag: discussion.id.toString(),
      builder: (_) => Scaffold(
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
            // Discussion Content (Header & Comments List)
            Expanded(
              child: Obx(() {
                // 1. Loading State
                if (controller.isLoading.value && controller.comments.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                // 2. Error State
                if (controller.errorMessage.isNotEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'Error: ${controller.errorMessage.value}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                // 3. Data View
                return SingleChildScrollView(
                  padding: EdgeInsets.all(mq.size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DiscussionHeader(discussion: controller.discussion.value),

                      SizedBox(height: mq.size.height * 0.03),

                      Container(
                        margin: EdgeInsets.only(top: mq.size.height * 0.01),
                        child: Obx(() => Text(
                              'Diskusi (${controller.comments.length})',
                              style: AppTextStyle.bodyText.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),

                      SizedBox(height: mq.size.height * 0.02),

                      // Daftar Komentar (dinamis dan rekursif)
                      ...controller.comments
                          .map((comment) => CommentCard(
                                comment: comment,
                                // Callback untuk mengirim balasan dari dalam CommentCard
                                onReplySubmitted: (commentId, content) async {
                                  // ✅ SOLUSI: Konversi String commentId menjadi Int
                                  final parentIdInt = int.tryParse(commentId);

                                  if (parentIdInt == null) {
                                    _showSnackbar(
                                        context, 'ID komentar tidak valid.',
                                        isSuccess: false);
                                    return;
                                  }

                                  final success = await controller.submitComment(
                                      body: content,
                                      parentId:
                                          parentIdInt // ✅ Menggunakan tipe Int yang dikonversi
                                      );

                                  if (success) {
                                    _showSnackbar(context,
                                        'Balasan berhasil ditambahkan!');
                                  } else {
                                    _showSnackbar(context,
                                        'Gagal mengirim balasan: ${controller.errorMessage.value}',
                                        isSuccess: false);
                                  }
                                },
                                nestingLevel: 0,
                              ))
                          .toList(),

                      SizedBox(height: mq.size.height * 0.02),
                    ],
                  ),
                );
              }),
            ),

            // Comment Input Utama (parentId: null)
            CommentInputWidget(
              commentController: controller.commentTextController,
              onCommentSubmitted: (content) async {
                // Kirim komentar utama (parentId: null)
                final success = await controller.submitComment(
                    body: content, parentId: null);

                if (success) {
                  _showSnackbar(context, 'Komentar berhasil ditambahkan!');
                } else {
                  _showSnackbar(context,
                      'Gagal mengirim komentar: ${controller.errorMessage.value}',
                      isSuccess: false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
