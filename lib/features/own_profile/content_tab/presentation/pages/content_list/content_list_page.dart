// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import 'package:schoolshare/features/own_profile/content_tab/data/datasources/dummy_content_uploaded.dart';
// import '../../../../../../data/datasources/home_mock_data.dart';
// import '../../../../../../data/models/publication.dart';
// import '../../../../../detail_content/presentation/pages/detail_content.dart';
// import '../content_submit/submit_content_page.dart';
// import '../../widgets/content_list/content_list_view.dart';
// import '../../widgets/empty_state/empty_state_view.dart';

// class ContentListPage extends StatelessWidget {
//   const ContentListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final mq = MediaQuery.of(context);
//     final horizontalPadding = mq.size.width * 0.05;
    
//     // ✅ Get user's submitted content from mock data
//     final List<Publication> submittedContent = HomeMockData.getUserContent();
    
//     print('📊 Submitted content count: ${submittedContent.length}');
//     if (submittedContent.isNotEmpty) {
//       print('📊 First publication: ${submittedContent.first.title}');
//       print('📊 First publication authors: ${submittedContent.first.authors.map((a) => a.name).toList()}');
//     }
    
//     // ✅ Toggle for testing - set false to test empty state
//     final bool hasContent = submittedContent.isNotEmpty; // Change to false for empty state test

//     return Scaffold(
//       backgroundColor: Colors.white,
      
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
//         child: hasContent 
//             ? ContentListView(
//                 content: submittedContent, // ✅ Pass List<Publication>
//                 onAddPressed: () {
//                   print('➕ Add content pressed');
//                   _navigateToSubmitPage(context);
//                 },
//                 onContentTap: (Publication publication) { // ✅ Proper typing
//                   print('📖 Content tapped: ${publication.title}');
//                   // _navigateToDetailPage(context, publication);
//                 },
//               )
//             : EmptyStateView(
//                 onAddPressed: () {
//                   print('➕ Add content from empty state');
//                   _navigateToSubmitPage(context);
//                 },
//               ),
//       ),
//     );
//   }

//   // ✅ Helper methods for navigation
//   void _navigateToSubmitPage(BuildContext context) {
//     try {
//       PersistentNavBarNavigator.pushNewScreen(
//         context,
//         screen: const SubmitContentPage(),
//         withNavBar: true, 
//         pageTransitionAnimation: PageTransitionAnimation.cupertino,
//       );
//       print('✅ Navigation to SubmitContentPage successful');
//     } catch (e) {
//       print('❌ Error navigating to SubmitContentPage: $e');
//     }
//   }

// //   void _navigateToDetailPage(BuildContext context, Publication publication) {
// //     try {
// //       PersistentNavBarNavigator.pushNewScreen(
// //         context,
// //         screen: DetailContent(content: publication), // ✅ Pass Publication object
// //         withNavBar: true, 
// //         pageTransitionAnimation: PageTransitionAnimation.cupertino,
// //       );
// //       print('✅ Navigation to DetailContent successful for: ${publication.title}');
// //     } catch (e) {
// //       print('❌ Error navigating to DetailContent: $e');
// //     }
// //   }
// // End of file
// }