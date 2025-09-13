import 'package:flutter/material.dart';
import '../../widgets/publication_widgets/publication_card.dart';

class PublicationSearchResult extends StatelessWidget {
  const PublicationSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final publications = [
      {
        'title': "Summary of Dawood Mamoon's Work on Chat GPT 4 by Chat GPT 4",
        'type': 'Video',
        'fullText': true,
        'date': 'Mei 2024',
        'authors': [
          {'name': 'Dawood Mamoon', 'photo': 'assets/images/example-profile.jpg'},
          {'name': 'Christ Marteen', 'photo': null},
                    {'name': 'Anggito Setoadji', 'photo': null},

        ],
        'reads': 1593,
      },
      {
        'title': "Talk Hive -Live Chat: A Realtime AI-Powered Chat Application",
        'type': 'Artikel',
        'fullText': true,
        'date': 'April 2025',
        'authors': [
          {'name': 'M.K.Jayanthi Kannan', 'photo': 'assets/images/example-profile.jpg'},
          {'name': 'Radhika Kumbhare', 'photo': null},
        ],
        'reads': 47,
      },
      {
        'title': "Session 3: Dawood Mamoon and Chat GPT 4: A Relationship with an AI",
        'type': 'Publikasi',
        'fullText': true,
        'date': 'Maret 2024',
        'authors': [
          {'name': 'Dawood Mamoon', 'photo': 'assets/images/example-profile.jpg'},
        ],
        'reads': 803,
      },

      {
        'title': "Penerapan LLM dalam Pengembangan Personalization Itinerary Builder untuk Aplikasi Wisata",
        'type': 'Skripsi',
        'fullText': true,
        'date': 'Juli 2025',
        'authors': [
          {'name': 'Anggito Setoadji', 'photo': 'assets/images/example-profile.jpg'},
        ],
        'reads': 803,
      },
      {
        'title': "Reflection on whether Chat GPT should be banned by academia from the perspective of education and teaching learning meditating in kalaamamawnawnanwan",
        'type': 'Publikasi',
        'fullText': true,
        'date': 'Juli 2025',
        'authors': [
          {'name': ' Hao Yu', 'photo': 'assets/images/example-profile.jpg'},
        ],
        'reads': 803,
      },
    ];

    return ListView.separated(

      padding: EdgeInsets.symmetric(
        horizontal: mq.size.width * 0.05,
        vertical: mq.size.height * 0.015,
      ),
      itemCount: publications.length,
      separatorBuilder: (_, __) => Divider(thickness: 0.9, color: Colors.grey.shade300),
      itemBuilder: (context, index) {
        final pub = publications[index];

        return PublicationCard(
          title: pub['title'] as String,
          type: pub['type'] as String,
          date: pub['date'] as String,
          authors: pub['authors'] as List<Map<String, dynamic>>,
          reads: pub['reads'] as int,
          onTap: () {
            debugPrint("Tapped: ${pub['title']}");
          },
        );
      },
    );
  }
}
