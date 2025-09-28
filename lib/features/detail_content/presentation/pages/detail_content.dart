import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/core/services/home/detail_content_services.dart';
import 'package:schoolshare/data/repositories/detail_content_repository_impl.dart';
import 'package:schoolshare/features/detail_content/presentation/controllers/detail_content_controller.dart';
import '../widgets/detail_description_card.dart';
import '../widgets/detail_info_card.dart';
import '../widgets/detail_stats_card.dart';
import '../widgets/detail_header.dart';

class DetailContent extends StatefulWidget {
  final String contentId;
  const DetailContent({super.key, required this.contentId});

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  // Simpan controller agar bisa diakses di dispose
  late DetailContentController controller;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan tag di initState
    controller = Get.put(
      DetailContentController(
        repository: DetailContentRepositoryImpl(
          service: DetailContentService(),
        ),
      ),
      tag: widget.contentId,
    );
    // Muat data segera setelah inisialisasi
    controller.loadDetail(widget.contentId);
  }

  @override
  void dispose() {
    // 🔥 Hapus controller saat widget dibuang (ditinggalkan)
    // Ini penting untuk membersihkan state dan menghindari kebocoran memori.
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
        return CustomScrollView(
          slivers: [
            DetailHeader(title: pub.title),
            SliverList(
              delegate: SliverChildListDelegate(
                [
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
