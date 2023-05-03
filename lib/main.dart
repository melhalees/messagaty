import 'package:flutter/material.dart';
import 'package:messagaty/screens/screens.dart';
import 'package:messagaty/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

Future main() async {

  await dotenv.load(fileName: ".env", mergeWith: {
    // "key": "value"
  });

  final streamChatClient = StreamChatClient(dotenv.get('STREAM_API_KEY'));

  runApp(MyApp(
    streamChatClient: streamChatClient,
    appTheme: AppTheme(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appTheme, required this.streamChatClient});

  final StreamChatClient streamChatClient;

  final AppTheme appTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messagaty',
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: const SelectUserScreen(),
      builder: (context, child) {
        return StreamChatCore(
          client: streamChatClient,
          child: child!,
        );
      }
    );
  }
}
