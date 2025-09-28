import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:schoolshare/models/models.dart';
import '../../../../../detail_content/presentation/pages/detail_content.dart';
import '../content_submit/submit_content_page.dart';
import '../content_edit/edit_content_page.dart';
import '../../widgets/content_list/content_list_view.dart';
import '../../widgets/empty_state/empty_state_view.dart';

class ContentListPage extends StatelessWidget {
  const ContentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.05;
    
    // Use Publication sample data
    final submittedContent = Publication.sampleData;
    
    // Toggle this to show empty state or content list
    final bool hasContent = submittedContent.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: hasContent 
            ? ContentListView(
                content: submittedContent,
                onAddPressed: () {
                  // Navigate to submit content page
                  print('Add content pressed - v2');
                  print('Navigating to submit content...');
                  try {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const SubmitContentPage(),
                      withNavBar: true, 
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                    print('Navigation to SubmitContentPage initiated successfully');
                  } catch (e) {
                    print('Error navigating to SubmitContentPage: $e');
                  }
                },
                onContentTap: (publication) {
                  // Navigate to detail content with publication data
                  print('Content tapped');
                  print('Navigating to detail content with publication: ${publication.title}');
                  try {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const DetailContent(),
                      withNavBar: true, 
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                    print('Navigation to DetailContent initiated successfully');
                  } catch (e) {
                    print('Error navigating to DetailContent: $e');
                  }
                },
                onContentEdit: (publication) {
                  // Navigate to edit content page
                  print('Edit content: ${publication.title}');
                  try {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: EditContentPage(publication: publication),
                      withNavBar: true, 
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                    print('Navigation to EditContentPage initiated successfully');
                  } catch (e) {
                    print('Error navigating to EditContentPage: $e');
                  }
                },
                onContentDelete: (publication) {
                  // Handle delete content
                  print('Delete content: ${publication.title}');
                  // Here you would typically call a service to delete the content
                  // For now, just show a success message
                },
              )
            : EmptyStateView(
                onAddPressed: () {
                  print('Add content pressed');
                  print('Navigating to submit content from empty state...');
                  try {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const SubmitContentPage(),
                      withNavBar: true, 
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                    print('Navigation to SubmitContentPage (empty state) initiated successfully');
                  } catch (e) {
                    print('Error navigating to SubmitContentPage (empty state): $e');
                  }
                },
              ),
      ),
    );
  }
}
