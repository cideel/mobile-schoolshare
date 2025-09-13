import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:schoolshare/data/models/content_submission.dart';
import 'package:schoolshare/features/other_profile/presentation/pages/header_other_profile_detail.dart';
import 'package:schoolshare/features/search/presentation/widgets/people_widgets/person_card.dart';

class PeopleSearchResult extends StatelessWidget {
  const PeopleSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy 
    final List<Map<String, String>> people = [
      {
        "name": "Johan Liebert",
        "school" : "SMKN 71 Jakarta",
        "photo": "assets/images/example-profile.jpg",
      },
      {
        "name": "Ratandi Ahmad Fauzan",
                "school" : "SMKN 71 Jakarta",

        "photo": "assets/images/example-profile-2.jpg",
      },
      {
        "name": "Silco Zaun",
                "school" : "SMKN 71 Jakarta",

        "photo": "assets/images/example-profile.jpg",
      },
      {
         "name": "Silco Zaun",
                 "school" : "SMKN 71 Jakarta",

        "photo": "assets/images/example-profile.jpg",
      },
      {
         "name": "Silco Zaun",
                 "school" : "SMKN 71 Jakarta",

        "photo": "assets/images/example-profile.jpg",
      },
      {
         "name": "Silco Zaun",
                 "school" : "SMKN 71 Jakarta",

        "photo": "assets/images/example-profile.jpg",
      },{
         "name": "Silco Zaun",
                 "school" : "SMKN 71 Jakarta",

        "photo": "assets/images/example-profile.jpg",
      },
      {
         "name": "Silco Zaun",
                 "school" : "SMKN 71 Jakarta",

        "photo": "assets/images/example-profile.jpg",
      },
      {
         "name": "Silco Zaun",
                 "school" : "SMKN 71 Jakarta",

        "photo": "assets/images/example-profile.jpg",
      },
      {
         "name": "Silco Zaun",
                 "school" : "SMKN 71 Jakarta",

        "photo": "assets/images/example-profile.jpg",
      },
      {
         "name": "Silco Zaun",
                 "school" : "SMKN 71 Jakarta",

        "photo": "assets/images/example-profile.jpg",
      },
      {
         "name": "Silco Zaun",
                 "school" : "SMKN 71 Jakarta",

        "photo": "assets/images/example-profile.jpg",
      }
  
    ];

    return ListView.builder(
      itemCount: people.length,
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
      itemBuilder: (context, index) {
        final person = people[index];

        return PersonCard(
          name: person['name'] ?? '',
          school: person['school'] ?? '',
          photoPath: person['photo'] ?? '',
          onTap: () {
            debugPrint("Klik: ${person['name']}");
            
            // Create UserProfile object from person data
            final userProfile = UserProfile(
              id: 'user_${index}_${person['name']?.replaceAll(' ', '_').toLowerCase()}',
              name: person['name'] ?? '',
              institution: person['school'] ?? '',
              profilePhoto: person['photo'] ?? '',
              email: '${person['name']?.replaceAll(' ', '.').toLowerCase()}@example.com',
            );
            
            // Navigate to other profile with persistent navbar
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: OtherProfilePage(userProfile: userProfile),
              withNavBar: true, // Keep the bottom navbar
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
        );
      },
    );
  }
}
