// lib/features/search/presentation/pages/discussion/discussion_search.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:schoolshare/features/search/presentation/controllers/discussion_controller.dart';
import '../../../../../data/models/discussion_item.dart';
import 'discussion_detail_page.dart';
import 'create_discussion_page.dart';
import '../../widgets/discussion_widgets/discussion_card.dart';
import '../../widgets/discussion_widgets/create_discussion_button.dart';


class DiscussionSearchResult extends GetView<DiscussionController> {
  const DiscussionSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    // Pastikan controller diinisialisasi
    if (!Get.isRegistered<DiscussionController>()) {
      Get.put(DiscussionController());
    }

    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Create Discussion Button
          CreateDiscussionButton(
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const CreateDiscussionPage(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),

          // Discussions List harus menggunakan Obx untuk reaktif
          Expanded(
            child: Obx(() {
              // 1. Loading State
              if (controller.isLoading.value && controller.items.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              // 2. Error State
              if (controller.errorMessage.isNotEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      'Error: ${controller.errorMessage.value}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }

              // 3. Empty State (Tidak ada hasil)
              if (controller.items.isEmpty) {
                return const Center(
                  child: Text(
                    "Tidak ada diskusi ditemukan.",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              // 4. Data State
              final discussions = controller.items;
              return ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: mq.size.width * 0.04,
                  vertical: mq.size.height * 0.015,
                ),
                itemCount: discussions.length,
                separatorBuilder: (_, __) => Divider(
                  thickness: 0.5,
                  color: Colors.grey[300],
                  height: mq.size.height * 0.02,
                ),
                itemBuilder: (context, index) {
                  final discussion = discussions[index];
                  return DiscussionCard(
                    discussion: discussion,
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: DiscussionDetailPage(discussion: discussion),
                        withNavBar: true,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
