// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:schoolshare/features/bookmark/controllers/bookmark_controller.dart';
// import '../../../core/constants/text_styles.dart';

// class UnbookmarkButton extends StatelessWidget {
//   final String bookmarkId;
//   final String bookmarkTitle;

//   const UnbookmarkButton({
//     super.key,
//     required this.bookmarkId,
//     required this.bookmarkTitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final mq = MediaQuery.of(context);
//     final controller = Get.find<BookmarkController>();

//     return GestureDetector(
//       onTap: () => _showRemoveDialog(context, controller),
//       child: Container(
//         padding: EdgeInsets.all(mq.size.width * 0.02),
//         decoration: BoxDecoration(
//           color: Colors.red.shade50,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: Colors.red.shade200, width: 1),
//         ),
//         child: Icon(
//           Icons.bookmark_remove,
//           color: Colors.red.shade600,
//           size: mq.size.width * 0.05,
//         ),
//       ),
//     );
//   }

//   void _showRemoveDialog(BuildContext context, BookmarkController controller) {
//     final mq = MediaQuery.of(context);

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(
//           'Hapus Bookmark',
//           style: AppTextStyle.sectionTitle.copyWith(
//             fontSize: mq.size.width * 0.045,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         content: Text(
//           'Apakah Anda yakin ingin menghapus bookmark ini?',
//           style: AppTextStyle.bodyText.copyWith(
//             fontSize: mq.size.width * 0.035,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text(
//               'Batal',
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//                 fontSize: mq.size.width * 0.035,
//               ),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               controller.removeBookmark(bookmarkId);
//             },
//             child: Text(
//               'Hapus',
//               style: TextStyle(
//                 color: Colors.red.shade600,
//                 fontSize: mq.size.width * 0.035,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
