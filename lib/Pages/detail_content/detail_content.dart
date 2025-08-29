import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/detail_description_card.dart';
import 'widgets/detail_info_card.dart';
import 'widgets/detail_stats_card.dart';
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
              [
                const DetailInfoCard(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                const DetailStatsCard(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                const DetailDescriptionCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
