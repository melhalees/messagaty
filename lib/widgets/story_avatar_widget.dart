import 'package:flutter/material.dart';
import 'package:messagaty/widgets/avatar_widget.dart';

import '../models/story_data_model.dart';

class StoryAvatarWidget extends StatelessWidget {
  const StoryAvatarWidget({
    Key? key,
    required this.storyData,
  }) : super(key: key);

  final StoryDataModel storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AvatarWidget.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}