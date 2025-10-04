import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/features/bookmark/controllers/bookmark_controller.dart';
import 'package:schoolshare/features/bookmark/domain/repositories/bookmark_repository.dart';
import 'package:schoolshare/core/services/bookmark/bookmark_service.dart';
import 'package:schoolshare/core/services/profile/header_profile_services.dart';
import '../widgets/bookmark_app_bar.dart';
import '../widgets/bookmark_loading_state.dart';
import '../widgets/bookmark_empty_state.dart';
import '../widgets/bookmark_card.dart';

class BookmarkListPage extends StatelessWidget {
  const BookmarkListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Setup dependencies
    final bookmarkService = BookmarkService();
    final profileService = HeaderProfileService();
    final repository = BookmarkRepositoryImpl(bookmarkService, profileService);
    final controller = Get.put(BookmarkController(repository));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BookmarkAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const BookmarkLoadingState();
        }
        
        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text('Gagal memuat bookmark'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchBookmarks(),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        if (controller.bookmarks.isEmpty) {
          return const BookmarkEmptyState();
        }

        return RefreshIndicator(
          onRefresh: () async => await controller.fetchBookmarks(),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
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