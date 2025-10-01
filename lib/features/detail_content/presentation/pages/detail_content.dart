// detail_content.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ... (Import-import lainnya tetap sama)
import 'package:schoolshare/core/services/home/detail_content_services.dart';
import 'package:schoolshare/data/repositories/detail_content_repository_impl.dart';
import 'package:schoolshare/features/detail_content/presentation/controllers/detail_content_controller.dart';
import 'package:schoolshare/data/models/publication.dart'; 
import '../widgets/detail_description_card.dart';
import '../widgets/detail_info_card.dart';
import '../widgets/detail_stats_card.dart';
import '../widgets/detail_header.dart';
import '../widgets/youtube_video_player.dart';

class DetailContent extends StatefulWidget {
// ... (Kode DetailContent StatefulWidget dan _DetailContentState initState/dispose tetap sama)
  final String contentId;
  const DetailContent({super.key, required this.contentId});

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  late DetailContentController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      DetailContentController(
        repository: DetailContentRepositoryImpl(
          service: DetailContentService(),
        ),
      ),
      tag: widget.contentId,
    );
    controller.loadDetail(widget.contentId);
  }

  @override
  void dispose() {
    Get.delete<DetailContentController>(tag: widget.contentId, force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text("Error: ${controller.errorMessage.value}"));
        }
        if (controller.publication.value == null) {
          return const Center(child: Text("Tidak ada data"));
        }

        final pub = controller.publication.value!;
        
        // 🔥 PERBAIKAN LOGIKA: 
        // 1. Menggunakan .toLowerCase() untuk tipe 'video'.
        // 2. Memeriksa pub.videoUrl (field yang benar untuk URL video).
        final isVideoContent = pub.type.toLowerCase() == 'video' && pub.videoUrl.isNotEmpty;

        return CustomScrollView(
          slivers: [
            DetailHeader(title: pub.title), 
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01), 

                  // Tampilkan YoutubeVideoPlayer jika konten adalah Video
                  if (isVideoContent) ...[
                    // MENGGUNAKAN pub.videoUrl!
                    YoutubeVideoPlayer(youtubeUrl: pub.videoUrl), 
                    SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  ],

                  DetailInfoCard(
                    publication: pub,
                    controller: controller,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                  DetailStatsCard(publication: pub),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                  DetailDescriptionCard(description: pub.description),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}