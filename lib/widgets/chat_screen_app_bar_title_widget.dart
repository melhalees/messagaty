import 'package:flutter/material.dart';
import 'package:messagaty/extensions/extensions.dart';
import 'package:messagaty/widgets/avatar_widget.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:messagaty/builder_widgets/builder_widgets.dart';

import '../helpers.dart';

class ChatScreenAppBarTitleWidget extends StatelessWidget {
  const ChatScreenAppBarTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final channel = StreamChannel.of(context).channel;

    return Row(
      children: [
        AvatarWidget.small(
          url: Helpers.getChannelImage(channel, context.currentUser!),
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
                Helpers.getChannelName(channel, context.currentUser!),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 2),
              ChatScreenUserStatusBuilderWidget(channel: channel,),
            ],
          ),
        )
      ],
    );
  }
}
