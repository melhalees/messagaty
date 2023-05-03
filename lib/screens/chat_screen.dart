import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:messagaty/widgets/widgets.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();

  static Route routeWithChannel(Channel channel) => MaterialPageRoute(
    builder: (context) => StreamChannel(
      channel: channel,
      child: const ChatScreen(),
    ),
  );
}

class _ChatScreenState extends State<ChatScreen> {

  late StreamSubscription<int> unreadCountSubscription;

  @override
  void initState() {
    super.initState();

    unreadCountSubscription = StreamChannel.of(context)
        .channel
        .state!
        .unreadCountStream
        .listen(_unreadCountHandler);
  }

  Future<void> _unreadCountHandler(int count) async {
    if (count > 0) {
      await StreamChannel.of(context).channel.markRead();
    }
  }

  @override
  void dispose() {
    unreadCountSubscription.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 54,
          leading: Align(
            alignment: Alignment.centerRight,
            child: FilledIconButtonWidget(
              icon: Ionicons.arrow_back,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: const ChatScreenAppBarTitleWidget(),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: OutlineIconButtonWidget(
                  icon: Ionicons.videocam,
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Center(
                child: OutlineIconButtonWidget(
                  icon: Ionicons.call,
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: MessageListCore(
                loadingBuilder: (context) {
                  return const Center(child: CircularProgressIndicator());
                },
                emptyBuilder: (context) => const SizedBox.shrink(),
                errorBuilder: (context, error) =>
                    DisplayErrorMessageWidget(error: error),
                messageListBuilder: (context, messages) =>
                    ChatScreenMessageListWidget(messages: messages),
              ),
            ),
            const ChatScreenSendMessageBarWidget()
          ],
        ),
      ),
    );
  }
}
