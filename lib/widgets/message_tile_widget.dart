import 'package:flutter/material.dart';
import 'package:messagaty/extensions/extensions.dart';
import 'package:messagaty/widgets/avatar_widget.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:messagaty/screens/screens.dart';
import 'package:messagaty/builder_widgets/builder_widgets.dart';

import '../helpers.dart';

class MessageTileWidget extends StatelessWidget {
  const MessageTileWidget({Key? key, required this.channel}) : super(key: key);

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(ChatScreen.routeWithChannel(channel));
      },
      child: Container(
        height: 85,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.1,
              color: Colors.grey,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AvatarWidget.medium(url: Helpers.getChannelImage(channel, context.currentUser!)),
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          Helpers.getChannelName(channel, context.currentUser!),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                          child: LastMessageBuilderWidget(channel: channel),
                      )
                    ],
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    LastMessageAtBuilderWidget(channel: channel),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(child: UnreadMessagesCountBuilderWidget(channel: channel))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
