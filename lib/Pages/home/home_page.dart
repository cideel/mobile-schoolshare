import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/Controller/home/home_controller.dart';
import 'package:schoolshare/Pages/detail_content/detail_content.dart';
import 'package:schoolshare/Pages/home/widgets/home_app_bar.dart';
import 'package:schoolshare/Pages/home/widgets/publication_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Gunakan Get.find() untuk mendapatkan instance HomeController.
    // GetX akan menemukannya karena sudah didaftarkan di main.dart.
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.white,
      // Obx akan secara otomatis membangun ulang widget anaknya
      // setiap kali properti yang diobservasi (publications, isLoading) berubah.
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (homeController.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              homeController.errorMessage.value,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
        }

        if (homeController.publications.isEmpty) {
          return const Center(
              child: Text("Tidak ada publikasi yang tersedia."));
        }

        return CustomScrollView(
          slivers: [
            const HomeAppBar(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // Pastikan untuk menampilkan data dari list yang diobservasi
                  final content = homeController.publications[index];
                  return PublicationItem(
                    content: content,
                    onTap: () {
                      // Gunakan Get.to() untuk navigasi yang lebih mudah
                      Get.to(() => DetailContent());
                    },
                  );
                },
                childCount: homeController.publications.length,
              ),
            ),
          ],
        );
      }),
    );
  }
}
