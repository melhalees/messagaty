import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:messagaty/screens/screens.dart';
import 'package:messagaty/widgets/widgets.dart';

class ContactTileWidget extends StatefulWidget {
  const ContactTileWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<ContactTileWidget> createState() => ContactTileWidgetState();
}

class ContactTileWidgetState extends State<ContactTileWidget> {
  Future<void> createChannel(BuildContext context) async {
    final core = StreamChatCore.of(context);
    final nav = Navigator.of(context);
    final channel = core.client.channel('messaging', extraData: {
      'members': [
        core.currentUser!.id,
        widget.user.id,
      ]
    });
    await channel.watch();

    nav.push(
      ChatScreen.routeWithChannel(channel),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        createChannel(context);
      },
      child: ListTile(
        leading: AvatarWidget.small(url: widget.user.image),
        title: Text(widget.user.name),
      ),
    );
  }
}