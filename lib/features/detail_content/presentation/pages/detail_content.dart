import 'package:flutter/material.dart';
import '../../../../models/content.dart';
import '../widgets/detail_description_card.dart';
import '../widgets/detail_info_card.dart';
import '../widgets/detail_stats_card.dart';
import '../widgets/detail_header.dart';
import '../widgets/youtube_video_player.dart';

class DetailContent extends StatelessWidget {
  final Content? content;
  
  const DetailContent({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const DetailHeader(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Add space from app bar
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                // Show YouTube video player if content type is Video
                if (content?.type == 'Video' && content?.fileUrl != null) ...[
                  YoutubeVideoPlayer(youtubeUrl: content!.fileUrl!),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                ],
                DetailInfoCard(content: content),
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
