// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:schoolshare/features/bookmark/controllers/bookmark_controller.dart';
// import '../widgets/bookmark_app_bar.dart';
// import '../widgets/bookmark_loading_state.dart';
// import '../widgets/bookmark_error_state.dart';
// import '../widgets/bookmark_empty_state.dart';
// import '../widgets/bookmarks_list.dart';

// class BookmarkListPage extends StatelessWidget {
//   const BookmarkListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(BookmarkController());

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const BookmarkAppBar(),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const BookmarkLoadingState();
//         }
        
//         if (controller.hasError.value) {
//           return BookmarkErrorState(controller: controller);
//         }

//         if (controller.bookmarks.isEmpty) {
//           return const BookmarkEmptyState();
//         }

//         return BookmarksList(controller: controller);
//       }),
//     );
//   }
// }