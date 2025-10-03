import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/features/search/presentation/controllers/publication_controller.dart';
import 'package:schoolshare/features/search/presentation/widgets/publication_widgets/publication_card.dart';
import 'package:schoolshare/core/utils/publication_type_formatter.dart'; // 🔥 import extension

class PublicationSearchResult extends StatelessWidget {
  const PublicationSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    final PublicationController controller = Get.find();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }

      if (controller.items.isEmpty) {
        return const Center(child: Text("Tidak ada publikasi ditemukan."));
      }

      return ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: controller.items.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final pub = controller.items[index];

          return PublicationCard(
            title: pub.title,
            type: pub.type.toTitleCaseType(), // 🔥 format otomatis
            date: pub.formattedPublishedDate,
            authors: pub.authors
                .map((a) => {
                      "name": a.name,
                      "photo": a.profileUrl,
                    })
                .toList(),
            reads: pub.readCount,
            onTap: () {
              debugPrint("Tapped: ${pub.title}");
            },
          );
        },
      );
    });
  }
}
