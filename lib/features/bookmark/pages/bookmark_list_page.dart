import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bookmark_controller.dart';
import '../widgets/bookmark_card.dart';

class BookmarkListPage extends StatelessWidget {
  const BookmarkListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookmarkController>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (controller.bookmarks.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada bookmark tersimpan',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }
        
        return RefreshIndicator(
          onRefresh: () => controller.fetchBookmarks(),
          child: ListView.builder(
            itemCount: controller.bookmarks.length,
            itemBuilder: (context, index) {
              final bookmark = controller.bookmarks[index];
              return BookmarkCard(bookmark: bookmark);
            },
          ),
        );
      }),
    );
  }
}
