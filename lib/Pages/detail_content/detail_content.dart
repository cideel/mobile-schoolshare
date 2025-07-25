import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schoolshare/Pages/detail_content/widgets/detail_description.dart';
import 'package:schoolshare/Pages/detail_content/widgets/detail_info_card.dart';
import 'package:schoolshare/Pages/detail_content/widgets/detail_stats.dart';
import 'widgets/detail_header.dart';


class DetailContent extends ConsumerWidget {
  const DetailContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const DetailHeader(),
          SliverList(
            delegate: SliverChildListDelegate(
              const [
                DetailInfoCard(),
                SizedBox(height: 10),
                DetailStatsCard(),
                SizedBox(height: 10),
                DetailDescriptionCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
