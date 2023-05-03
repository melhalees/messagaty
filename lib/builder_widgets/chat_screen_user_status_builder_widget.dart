import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:messagaty/builder_widgets/builder_widgets.dart';
import 'package:messagaty/theme.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:collection/collection.dart' show IterableExtension;

class ChatScreenUserStatusBuilderWidget extends StatelessWidget {
  const ChatScreenUserStatusBuilderWidget({Key? key, required this.channel}) : super(key: key);

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return BetterStreamBuilder<List<Member>>(
      stream: channel.state!.membersStream,
      initialData: channel.state!.members,
      builder: (context, data) => ConnectionStatusBuilder(
        statusBuilder: (context, status) {
          switch (status) {
            case ConnectionStatus.connected:
              return _buildConnectedTitleState(context, data);
            case ConnectionStatus.connecting:
              return const Text(
                'Connecting...',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textFaded,
                ),
              );
            case ConnectionStatus.disconnected:
              return const Text(
                'No internet connection',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildConnectedTitleState(
      BuildContext context,
      List<Member>? members,
      ) {
    Widget? alternativeWidget;
    final channel = StreamChannel.of(context).channel;
    final memberCount = channel.memberCount;
    if (memberCount != null && memberCount > 2) {
      var text = '$memberCount members';
      // final watcherCount = channel.state?.watcherCount ?? 0;
      // if (watcherCount > 0) {
      //   text = 'watchers $watcherCount';
      // }
      alternativeWidget = Text(
        text,
      );
    } else {
      final userId = StreamChatCore.of(context).currentUser?.id;
      final otherMember = members?.firstWhereOrNull(
            (element) => element.userId != userId,
      );

      if (otherMember != null) {
        if (otherMember.user?.online == true) {
          alternativeWidget = const Text(
            'Online',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          );
        } else {
          alternativeWidget = Text(
            'Last seen '
                '${Jiffy(otherMember.user?.lastActive).fromNow()}',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppColors.textFaded,
            ),
          );
        }
      }
    }

    return ChatScreenTypingStatusBuilderWidget(
      alternativeWidget: alternativeWidget,
    );
  }
}
