import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../../../../data/models/publication.dart';
import '../content_submit/simple_video_submit_page.dart';
import '../../widgets/content_list/content_list_view.dart';
import '../../widgets/empty_state/empty_state_view.dart';
import '../../controllers/user_content_controller_active.dart';
import '../../bindings/user_content_binding.dart';

class ContentListPage extends StatelessWidget {
  const ContentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize dependencies if not already done
    if (!Get.isRegistered<UserContentController>()) {
      UserContentBinding().dependencies();
    }

    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: GetX<UserContentController>(
          builder: (controller) {
            // Show loading state
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // Show error state with retry option
            if (controller.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading content',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.error,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => controller.refreshUserContent(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            // Show content or empty state
            final submittedContent = controller.userContents;
            final hasContent = submittedContent.isNotEmpty;

            print('📊 Submitted content count: ${submittedContent.length}');
            if (submittedContent.isNotEmpty) {
              print('📊 First publication: ${submittedContent.first.title}');
              print('📊 First publication authors: ${submittedContent.first.authors.map((a) => a.name).toList()}');
            }

            return hasContent
                ? ContentListView(
                    content: submittedContent, // ✅ Pass List<Publication> from API
                    onAddPressed: () {
                      print('➕ Add content pressed');
                      _navigateToSubmitPage(context);
                    },
                    onContentTap: (Publication publication) {
                      // ✅ Proper typing
                      print('📖 Content tapped: ${publication.title}');
                      // _navigateToDetailPage(context, publication);
                    },
                  )
                : EmptyStateView(
                    onAddPressed: () {
                      print('➕ Add content from empty state');
                      _navigateToSubmitPage(context);
                    },
                  );
          },
        ),
      ),
    );
  }

  // ✅ Helper methods for navigation
  void _navigateToSubmitPage(BuildContext context) {
    try {
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const SimpleVideoSubmitPage(),
        withNavBar: true, 
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
      print('✅ Navigation to SimpleVideoSubmitPage successful');
    } catch (e) {
      print('❌ Error navigating to SimpleVideoSubmitPage: $e');
    }
  }

//   void _navigateToDetailPage(BuildContext context, Publication publication) {
//     try {
//       PersistentNavBarNavigator.pushNewScreen(
//         context,
//         screen: DetailContent(content: publication), // ✅ Pass Publication object
//         withNavBar: true, 
//         pageTransitionAnimation: PageTransitionAnimation.cupertino,
//       );
//       print('✅ Navigation to DetailContent successful for: ${publication.title}');
//     } catch (e) {
//       print('❌ Error navigating to DetailContent: $e');
//     }
//   }
// End of file
}