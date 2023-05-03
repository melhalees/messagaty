import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:messagaty/models/models.dart';
import 'package:messagaty/widgets/widgets.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key, required this.lastMessageTileDataModel}) : super(key: key);

  final MessageTileDataModel lastMessageTileDataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: ChatScreenAppBarTitleWidget(
          messageTileDataModel: lastMessageTileDataModel,
        ),
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
        children: const [
          Expanded(
            child: DemoMessageListWidget(),
          ),
          ChatScreenSendMessageBarWidget()
        ],
      ),
    );
  }

  static Route openChat({required MessageTileDataModel lastMessageTileDataModel}) {
    return MaterialPageRoute<void>(
      builder: (_) => ChatScreen(lastMessageTileDataModel: lastMessageTileDataModel),
    );
  }
}
