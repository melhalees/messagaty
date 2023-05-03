import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:messagaty/pages/pages.dart';
import 'package:messagaty/widgets/widgets.dart';

import '../helpers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  ValueNotifier<String> title = ValueNotifier<String>('Messages');

  final pages = const [
    MessagesPage(),
    CallsPage(),
    ContactsPage(),
    ProfilePage()
  ];

  final pageTitles = const [
    'Messages',
    'Calls',
    'Contacts',
    'Profile'
  ];

  void _onItemSelected(int index) {
    selectedIndex.value = index;
    title.value = pageTitles[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: FilledIconButtonWidget(
            icon: Ionicons.search,
            onTap: () {},
          ),
        ),
        title: ValueListenableBuilder<String>(
          valueListenable: title,
          builder: (context, value, child) {
            return Text(
                value,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                ),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: AvatarWidget.small(url: Helpers.randomPictureUrl(),),
          ),
        ],
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (context, index, child) {
          return pages[index];
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        onItemSelected: _onItemSelected,
      ),
    );
  }
}