import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:messagaty/widgets/message_tile_widget.dart';
import 'package:messagaty/widgets/stories_list_widget.dart';
import 'package:messagaty/models/models.dart';

import '../helpers.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: StoriesListWidget(),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(_handleSliverChildBuilderDelegate),
        ),
      ],
    );
  }

  Widget _handleSliverChildBuilderDelegate(BuildContext context, int index) {
    Faker faker = Faker();
    final date = Helpers.randomDate();

    return MessageTileWidget(
      data: MessageTileDataModel(
        senderName: faker.person.name(),
        senderImage: Helpers.randomPictureUrl(),
        messageText: faker.lorem.sentence(),
        messageDateTime: date,
        messageDateTimeAsString: Jiffy(date).fromNow(),
        isMessageRead: false,
        isMessageSent: true,
        isMessageDelivered: true,
      ),
    );
  }
}
