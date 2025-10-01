import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/data/models/content_submission.dart';
import 'package:schoolshare/features/other_profile/presentation/pages/header_other_profile_detail.dart';
import 'package:schoolshare/features/search/presentation/controllers/people_controller.dart';
import 'package:schoolshare/features/search/presentation/widgets/people_widgets/person_card.dart';

class PeopleSearchResult extends StatelessWidget {
  const PeopleSearchResult({super.key});

  // Helper untuk ambil inisial nama
  String _getInitials(String name) {
    final parts = name.trim().split(" ");
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    } else {
      return (parts[0][0] + parts.last[0]).toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    final PeopleController controller = Get.find();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text("Error: ${controller.errorMessage}"));
      }

      if (controller.items.isEmpty) {
        return const Center(child: Text("Tidak ada pengguna ditemukan."));
      }

      return ListView.builder(
        itemCount: controller.items.length,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemBuilder: (context, index) {
          final person = controller.items[index];

          // Ambil institusi pertama dari list, jangan toString() seluruh list
          final String school =
              (person.institutionId != null && person.institutionId!.isNotEmpty)
                  ? person.institutionId!.first.toString()
                  : "Tidak ada institusi";

          final String? photoPath =
              (person.profile != null && person.profile!.isNotEmpty)
                  ? "${ApiUrls.storageUrl}/${person.profile}"
                  : null;

          return PersonCard(
            name: person.name,
            school: school,
            photoPath: photoPath,
            initials: _getInitials(person.name),
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: OtherProfilePage(
                  userProfile: person,
                ),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          );
        },
      );
    });
  }
}
