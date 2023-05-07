import 'package:flutter/material.dart';
import 'package:messagaty/extensions/extensions.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import '../logger.dart';
import '../widgets/widgets.dart';
import 'package:messagaty/screens/screens.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = context.currentUser;

    return  Center(
      child: Column(
        children: [
          AvatarWidget.large(url: user?.image),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(user?.name ?? 'No name'),
          ),
          const Divider(),
          const _SignOutButton(),
        ],
      ),
    );
  }
}

class _SignOutButton extends StatefulWidget {
  const _SignOutButton({
    Key? key,
  }) : super(key: key);

  @override
  __SignOutButtonState createState() => __SignOutButtonState();
}

class __SignOutButtonState extends State<_SignOutButton> {
  bool _loading = false;

  Future<void> _signOut() async {
    setState(() {
      _loading = true;
    });

    try {
      await StreamChatCore.of(context).client.disconnectUser();
      await firebase.FirebaseAuth.instance.signOut();

      Navigator.of(context).pushReplacement(SplashScreen.route);
    } on Exception catch (e, st) {
      logger.e('Could not sign out', e, st);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const CircularProgressIndicator()
        : TextButton(
      onPressed: _signOut,
      child: const Text('Sign out'),
    );
  }
}
