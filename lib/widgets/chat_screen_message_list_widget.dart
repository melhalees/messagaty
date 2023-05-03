import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:messagaty/extensions/extensions.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:messagaty/widgets/widgets.dart';

class ChatScreenMessageListWidget extends StatelessWidget {
  const ChatScreenMessageListWidget({Key? key, required this.messages}) : super(key: key);

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.separated(
        itemCount: messages.length + 1,
        reverse: true,
        separatorBuilder: (context, index) {
          if (index == messages.length - 1) {
            return ChatScreenDateLabelWidget(dateTime: messages[index].createdAt);
          }
          if (messages.length == 1) {
            return const SizedBox.shrink();
          } else if (index >= messages.length - 1) {
            return const SizedBox.shrink();
          } else if (index <= messages.length) {
            final message = messages[index];
            final nextMessage = messages[index + 1];
            if (!Jiffy(message.createdAt.toLocal())
                .isSame(nextMessage.createdAt.toLocal(), Units.DAY)) {
              return ChatScreenDateLabelWidget(
                dateTime: message.createdAt,
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }
        },
        itemBuilder: (context, index) {
          if (index < messages.length) {
            final message = messages[index];
            if (message.user?.id == context.currentUser?.id) {
              message.status.toString();
              return ChatScreenOwnMessageWidget(message: message);
            } else {
              return ChatScreenMessageWidget(message: message);
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
