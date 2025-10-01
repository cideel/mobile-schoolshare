// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:schoolshare/data/models/bookmark_model.dart';
// import '../../../core/constants/color.dart';
// import 'bookmark_content_info.dart';
// import 'bookmark_authors_list.dart';
// import 'bookmark_statistics.dart';
// import 'unbookmark_button.dart';

// class BookmarkCard extends StatelessWidget {
//   final Bookmark bookmark;

//   const BookmarkCard({
//     super.key,
//     required this.bookmark,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final mq = MediaQuery.of(context);

//     return GestureDetector(
//       onTap: () => _onBookmarkTap(),
//       child: Container(
//         margin: EdgeInsets.symmetric(
//           horizontal: mq.size.width * 0.04,
//           vertical: mq.size.height * 0.01,
//         ),
//         padding: EdgeInsets.all(mq.size.width * 0.04),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: Colors.grey.shade300,
//             width: 1,
//           ),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   BookmarkContentInfo(
//                     title: bookmark.title,
//                     contentType: bookmark.contentType,
//                     date: bookmark.bookmarkedAt,
//                   ),
//                   SizedBox(height: mq.size.height * 0.012),
//                   BookmarkAuthorsList(
//                     authors: bookmark.authors,
//                     avatarSize: mq.size.width * 0.08,
//                   ),
//                   SizedBox(height: mq.size.height * 0.012),
//                   BookmarkStatistics(
//                     viewCount: bookmark.viewCount,
//                     downloadCount: bookmark.downloadCount,
//                     recommendationCount: bookmark.recommendationCount,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(width: mq.size.width * 0.03),
//             UnbookmarkButton(
//               bookmarkId: bookmark.id,
//               bookmarkTitle: bookmark.title,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _onBookmarkTap() {
//     Get.snackbar(
//       'Konten Dipilih',
//       'Membuka: ${bookmark.title}',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColor.componentColor.withOpacity(0.9),
//       colorText: Colors.white,
//       duration: const Duration(seconds: 2),
//     );
//   }
// }