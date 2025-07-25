import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtherProfilePage extends StatelessWidget {
  const OtherProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Column(
          children: [
            // Profile info section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mq.size.width * 0.05,
                vertical: mq.size.height * 0.015,
              ),
              child: Column(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: mq.size.width * 0.12,
                    backgroundImage:
                        const AssetImage('assets/images/example-profile.jpg'),
                  ),
                  SizedBox(height: mq.size.height * 0.015),

                  // Name
                  Text(
                    "Ton That Chat",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: mq.size.height * 0.008),

                  // Title & Affiliation
                  Text(
                    "Assoc.Prof.PhD of Aquaculture; Senior lecturer • Lecturer at Hue University",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: mq.size.height * 0.006),

                  // Location
                  Text(
                    "Vietnam",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: mq.size.height * 0.015),

                  // Follow Button
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Follow",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // TabBar
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: const [
                Tab(text: 'Profile'),
                Tab(text: 'Research'),
                Tab(text: 'Stats'),
              ],
            ),

            // TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  _ProfileTab(mq: mq),
                  const Center(child: Text("Research content")),
                  const Center(child: Text("Stats content")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  final MediaQueryData mq;
  const _ProfileTab({required this.mq});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: mq.size.width * 0.05,
        vertical: mq.size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Introduction",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
          SizedBox(height: mq.size.height * 0.01),
          Text(
            "1990 - 1993; TTHue Aquaculture Service. 53 Nguyen Hue, Hue, Officer of Aquaculture Motivation. 1993 - 2010 Hue University of Agriculture and Forestry, Lecturer; Head of Department of Aquaculture, Faculty of Domestic Animal Sciences (1997–2004); Vice Dean of the Faculty of Fisheries at Hue University of Agriculture and Forestry (2005 - 2009); Head of Department of Marine Aquaculture, Faculty of Fisheries - 2009. 2010–Present Hue University of Agriculture...",
            style: TextStyle(
              fontSize: 13.sp,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
