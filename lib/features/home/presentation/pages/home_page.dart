import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/features/detail_content/presentation/pages/detail_content.dart';
import 'package:schoolshare/controllers/controllers.dart';
import '../widgets/content_ontap.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/loading_indicator.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.find<NavigationController>();
    
    return Scaffold(
      backgroundColor: Colors.white, 
      body: RefreshIndicator(
        onRefresh: controller.refreshData,
        child: CustomScrollView(
          slivers: [
            const HomeAppBar(),
            
            // Konten list
            Obx(() {
              if (controller.isLoading && controller.contents.isEmpty) {
                return const SliverToBoxAdapter(
                  child: LoadingIndicator(),
                );
              }
              
              if (controller.contents.isEmpty) {
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
                    final content = controller.contents[index];
                    return PublicationItem(
                      content: content,
                      index: index,
                      onTap: () {
                        navigationController.navigateToDetail(
                          const DetailContent(),
                        );
                      },
                    );
                  },
                  childCount: controller.contents.length,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
