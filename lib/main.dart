import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messagaty/firebase_options.dart';
import 'package:messagaty/screens/screens.dart';
import 'package:messagaty/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:stream_chat_localizations/stream_chat_localizations.dart';


Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: const SplashScreen(),
      builder: (context, child) {
        return StreamChatCore(
          client: streamChatClient,
          child: child!,
        );
      },
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ]
    );
  }
}
