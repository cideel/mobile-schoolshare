import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:schoolshare/features/detail_content/presentation/pages/detail_content.dart';
import '../../controllers/home_controller.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/publication_item.dart';
import '../widgets/loading_indicator.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: RefreshIndicator(
        onRefresh: controller.refreshData,
        child: CustomScrollView(
          slivers: [
            const HomeAppBar(),
            
            // Konten list
            Obx(() {
              if (controller.isLoading && controller.publications.isEmpty) {
                return const SliverToBoxAdapter(
                  child: LoadingIndicator(),
                );
              }
              
              if (controller.publications.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.article_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Belum ada konten',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final publication = controller.publications[index];
                    return PublicationItem(
                      publication: publication,
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const DetailContent(),
                          withNavBar: true, // IMPORTANT: This keeps the navbar
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                    );
                  },
                  childCount: controller.publications.length,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
