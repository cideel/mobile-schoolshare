import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Config/text_styles.dart';

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

        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul
              Text(
                textAlign: TextAlign.start,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                pub['title'] as String,
                style: AppTextStyle.cardTitle.copyWith(fontSize: 16.sp),
              ),
              SizedBox(height: mq.size.height * 0.008),
          
              // Tag
              Row(
                children: [
                  _buildTag(pub['type'].toString(), bgColor: AppColor.componentColor),
                  SizedBox(width: mq.size.width * 0.02),
                  
                ],
              ),
              SizedBox(height: mq.size.height * 0.008),
          
              // Tanggal
              Text(
                pub['date'] as String,
                style: AppTextStyle.dateText.copyWith(fontSize: 13.sp),
              ),
              SizedBox(height: mq.size.height * 0.008),
          
              // Authors
              Wrap(
                spacing: mq.size.width * 0.02,
                runSpacing: 4,
                children: (pub['authors'] as List)
                    .map<Widget>((author) => _buildAuthor(author, mq))
                    .toList(),
              ),
              SizedBox(height: mq.size.height * 0.008),
          
              // Reads
              Text(
                "${pub['reads']} Dibaca",
                style: AppTextStyle.readCount.copyWith(fontSize: 13.sp),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTag(String text, {Color? bgColor, bool border = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.white,
        border: border ? Border.all(color: Colors.grey.shade400) : null,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: AppTextStyle.badge.copyWith(fontSize: 12.sp),
      ),
    );
  }

  Widget _buildAuthor(Map<String, dynamic> author, MediaQueryData mq) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: mq.size.width * 0.025,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: author['photo'] != null ? AssetImage(author['photo']) : null,
          child: author['photo'] == null
              ? Icon(Icons.person, size: mq.size.width * 0.03, color: Colors.white)
              : null,
        ),
        SizedBox(width: mq.size.width * 0.015),
        Text(
          author['name'],
          style: AppTextStyle.authorName.copyWith(fontSize: 13.sp),
        )
      ],
    );
  }
}
