import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/text_styles.dart';

class PeopleSearchResult extends StatelessWidget {
  const PeopleSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

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
      padding: EdgeInsets.symmetric(
        vertical: mq.size.height * 0.015,
        horizontal: mq.size.width * 0.04,
      ),
      itemBuilder: (context, index) {
        final person = people[index];

        return Padding(
          padding: EdgeInsets.symmetric(vertical: mq.size.height * 0.008),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: mq.size.width * 0.01,
            ),
            leading: CircleAvatar(
              backgroundImage: AssetImage(person['photo'] ?? ''),
              radius: mq.size.width * 0.07, 
            ),
            title: Text(
              person['name'] ?? '',
              style: AppTextStyle.cardTitle.copyWith(
                fontSize: 16.sp,
              ),
            ),
            subtitle: Text(person['school']??'',
            style: AppTextStyle.caption.copyWith(fontSize: 14.sp)),
            onTap: () {
              debugPrint("Klik: ${person['name']}");
            },
          ),
        );
      },
    );
  }
}
