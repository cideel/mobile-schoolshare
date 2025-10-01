// import 'package:flutter/material.dart';
// import 'package:schoolshare/features/bookmark/controllers/bookmark_controller.dart';
// import '../../../core/constants/color.dart';
// import 'bookmark_card.dart';

// class BookmarksList extends StatelessWidget {
//   final BookmarkController controller;

//   const BookmarksList({
//     super.key,
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final mq = MediaQuery.of(context);

//     return RefreshIndicator(
//       onRefresh: () async => await controller.refreshBookmarks(),
//       color: AppColor.componentColor,
//       child: ListView.builder(
//         padding: EdgeInsets.only(
//           top: mq.size.height * 0.01,
//           bottom: mq.size.height * 0.02,
//         ),
//         itemCount: controller.bookmarks.length,
//         itemBuilder: (context, index) {
//           final bookmark = controller.bookmarks[index];
//           return BookmarkCard(bookmark: bookmark);
//         },
//       ),
//     );
//   }
// }
