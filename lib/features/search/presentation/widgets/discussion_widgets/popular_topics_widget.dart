import 'package:flutter/material.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class PopularTopicsWidget extends StatelessWidget {
  final List<String> topics;
  final Function(String) onTopicSelected;

  const PopularTopicsWidget({
    super.key,
    required this.topics,
    required this.onTopicSelected,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Topik Populer',
          style: AppTextStyle.caption.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: mq.size.height * 0.008),
        
        Wrap(
          spacing: mq.size.width * 0.02,
          runSpacing: mq.size.height * 0.008,
          children: topics.map((topic) => GestureDetector(
            onTap: () => onTopicSelected(topic),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: mq.size.width * 0.03,
                vertical: mq.size.height * 0.006,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                topic,
                style: AppTextStyle.caption.copyWith(
                  color: Colors.grey[700],
                ),
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }
}
