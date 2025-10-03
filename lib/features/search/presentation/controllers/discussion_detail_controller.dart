// lib/features/discussion/presentation/controllers/discussion_detail_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/core/services/forum/forum_service.dart';
import 'package:schoolshare/data/models/comment_item.dart';
import 'package:schoolshare/data/models/discussion_item.dart';
import 'package:schoolshare/data/repositories/forum_repository_impl.dart';
import 'package:schoolshare/features/search/presentation/domain/repositories/forum_repository.dart';

class DiscussionDetailController extends GetxController {
  final ForumRepository _repository;
  final DiscussionItem initialDiscussion;
  final TextEditingController commentTextController = TextEditingController();

  // State
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  // Data Dinamis
  final Rx<DiscussionItem> discussion = DiscussionItem.empty().obs;
  final RxList<CommentItem> comments =
      <CommentItem>[].obs; // Komentar yang sudah di-tree

  DiscussionDetailController(
      {required this.initialDiscussion, ForumRepository? repository})
      : _repository =
            repository ?? ForumRepositoryImpl(service: ForumService()) {
    discussion.value = initialDiscussion;
  }

  @override
  void onInit() {
    fetchForumDetail();
    super.onInit();
  }

  @override
  void onClose() {
    commentTextController.dispose();
    super.onClose();
  }

  // ---------------------- LOGIC UTAMA ----------------------

  Future<void> fetchForumDetail() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final data = await _repository.fetchForumDetail(initialDiscussion.id);

      // Map data forum utama
      final updatedDiscussion = DiscussionItem.fromJson(data);
      discussion.value = updatedDiscussion;

      // Map dan proses komentar
      final flatComments = (data['comments'] as List)
          .map((json) => CommentItem.fromJson(json as Map<String, dynamic>))
          .toList();

      // Konversi flat list menjadi tree/nested replies
      comments.assignAll(_buildCommentTree(flatComments));
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      comments.clear();
      debugPrint('Fetch Forum Detail Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------------- POST COMMENT (FINAL FIX) ----------------------

  Future<bool> submitComment({
    required String body,
    int? parentId, // null untuk komen utama
  }) async {
    if (body.trim().isEmpty) return false;

    try {
      // 1. Kirim ke API (asumsi repository mengembalikan objek atau berhasil)
      // Kita tidak perlu menggunakan hasil kembaliannya karena kita akan refetch
      await _repository.postComment(
        forumId: discussion.value.id,
        body: body,
        parentId: parentId,
      );

      // 2. Refresh data untuk memperbarui list komentar dan commentCount
      // Metode ini lebih aman dan menghindari error manipulasi list lokal.
      await fetchForumDetail();

      return true;
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      debugPrint('Submit Comment Error: $e');
      return false;
    }
  }

  // ---------------------- HELPER FUNCTIONS: COMMENT TREEING (FINAL FIX) ----------------------

  // Helper untuk mengubah flat list menjadi comment tree
  List<CommentItem> _buildCommentTree(List<CommentItem> flatComments) {
    // 1. Buat map ID ke komentar.
    // Kita gunakan list yang di-map sebagai referensi.
    final Map<int, CommentItem> map = {};
    final List<CommentItem> rootComments = [];

    // Inisialisasi map dan pastikan setiap komentar memiliki list replies kosong
    for (var comment in flatComments) {
      // ✅ Solusi: Jika CommentItem immutable, Anda harus menggunakan copyWith di sini
      // untuk memastikan list replies-nya kosong saat mapping.
      final commentWithEmptyReplies = comment.copyWith(replies: []);
      map[commentWithEmptyReplies.id] = commentWithEmptyReplies;
    }

    // 2. Bangun struktur tree
    for (var comment in map.values) {
      if (comment.parentId == null || comment.parentId == 0) {
        // Ini adalah komentar root
        rootComments.add(comment);
      } else {
        // Ini adalah balasan
        final parent = map[comment.parentId];
        if (parent != null) {
          // Tambahkan komentar ke list replies parent.
          // Karena kita mengambil referensi dari map, perubahan di sini akan
          // terlihat pada objek parent.
          parent.replies.add(comment);
        }
      }
    }

    // Urutkan balasan di setiap level (jika perlu)
    for (var root in rootComments) {
      _sortReplies(root.replies);
    }

    // Urutkan komentar utama (root) dari yang terbaru
    rootComments.sort((a, b) => (b.createdAt ?? DateTime(1970))
        .compareTo(a.createdAt ?? DateTime(1970)));

    return rootComments;
  }

  // Helper rekursif untuk mengurutkan balasan
  void _sortReplies(List<CommentItem> replies) {
    replies.sort((a, b) => (b.createdAt ?? DateTime(1970))
        .compareTo(a.createdAt ?? DateTime(1970)));

    for (var reply in replies) {
      if (reply.replies.isNotEmpty) {
        _sortReplies(reply.replies);
      }
    }
  }
}
