import 'package:flutter/material.dart';
import 'package:messagaty/models/models.dart';
import 'package:messagaty/widgets/avatar_widget.dart';

class ChatScreenAppBarTitleWidget extends StatelessWidget {
  const ChatScreenAppBarTitleWidget({Key? key, required this.messageTileDataModel}) : super(key: key);

  final MessageTileDataModel messageTileDataModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AvatarWidget.small(
          url: messageTileDataModel.senderImage,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                messageTileDataModel.senderName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 2),
              const Text(
                'Online now',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
