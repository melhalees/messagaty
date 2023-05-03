import 'package:flutter/material.dart';
import 'package:messagaty/widgets/message_tile_widget.dart';
import 'package:messagaty/widgets/stories_list_widget.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

  late final channelListController = StreamChannelListController(
    client: StreamChatCore.of(context).client,
    filter: Filter.and(
      [
        Filter.equal('type', 'messaging'),
        Filter.in_('members', [
          StreamChatCore.of(context).currentUser!.id,
        ])
      ],
    ),
  );

  @override
  void initState() {
    channelListController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    channelListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return PagedValueListenableBuilder<int, Channel>(
      valueListenable: channelListController,
      builder: (context, value, child) {
        return value.when(
              (channels, nextPageKey, error) {
            if (channels.isEmpty) {
              return const Center(
                child: Text(
                  'So empty.\nGo and message someone.',
                  textAlign: TextAlign.center,
                ),
              );
            }
            return LazyLoadScrollView(
              onEndOfPage: () async {
                if (nextPageKey != null) {
                  channelListController.loadMore(nextPageKey);
                }
              },
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: StoriesListWidget(),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return MessageTileWidget(
                          channel: channels[index],
                        );
                      },
                      childCount: channels.length,
                    ),
                  )
                ],
              ),
            );
          },
          loading: () => const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
          ),
          error: (e) => Center(
            child: Text(
              'Oh no, something went wrong. '
                  'Please check your config. $e',
            ),
          ),
        );
      },
    );

  }
}
