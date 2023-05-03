import 'package:messagaty/faker/fakers.dart';
import 'package:messagaty/models/models.dart';
import 'package:flutter/material.dart';
import 'package:messagaty/widgets/avatar_widget.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'screens.dart';
import '../logger.dart';

class SelectUserScreen extends StatefulWidget {
  const SelectUserScreen({super.key});

  static Route get route => MaterialPageRoute(
    builder: (context) => const SelectUserScreen(),
  );

  @override
  State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  bool _loading = false;

  Future<void> onUserSelected(UserDataModel user) async {
    setState(() {
      _loading = true;
    });

    try {
      final client = StreamChatCore.of(context).client;
      await client.connectUser(
        User(
          id: user.id,
          extraData: {
            'name': user.name,
            'image': user.image,
          },
        ),
        client.devToken(user.id).rawValue,
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );

    } on Exception catch (e, st) {
      logger.e('Could not connect user', e, st);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (_loading)
            ? const CircularProgressIndicator()
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(32.0),
                child: Text(
                  'Select a user',
                  style: TextStyle(fontSize: 24, letterSpacing: 0.4),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: usersFaker.length,
                  itemBuilder: (context, index) {
                    return SelectUserButton(
                      user: usersFaker[index],
                      onPressed: onUserSelected,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectUserButton extends StatelessWidget {
  const SelectUserButton({
    Key? key,
    required this.user,
    required this.onPressed,
  }) : super(key: key);

  final UserDataModel user;

  final Function(UserDataModel user) onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () => onPressed(user),
        child: Row(
          children: [
            AvatarWidget.large(url: user.image),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                user.name,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}