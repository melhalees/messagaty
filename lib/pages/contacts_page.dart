import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:messagaty/widgets/widgets.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late final userListController = StreamUserListController(
    client: StreamChatCore.of(context).client,
    limit: 20,
    filter: Filter.notEqual('id', StreamChatCore.of(context).currentUser!.id),
  );

  @override
  void initState() {
    userListController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    userListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedValueListenableBuilder<int, User>(
      valueListenable: userListController,
      builder: (context, value, child) {
        return value.when(
              (users, nextPageKey, error) {
            if (users.isEmpty) {
              return const Center(child: Text('There are no users'));
            }
            return LazyLoadScrollView(
              onEndOfPage: () async {
                if (nextPageKey != null) {
                  userListController.loadMore(nextPageKey);
                }
              },
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ContactTileWidget(user: users[index]);
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e) => DisplayErrorMessageWidget(error: e),
        );
      },
    );
  }
}
