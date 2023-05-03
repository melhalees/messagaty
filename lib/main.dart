import 'package:flutter/material.dart';
import 'package:messagaty/screens/screens.dart';
import 'package:messagaty/theme.dart';

void main() {
  runApp(MyApp(
    appTheme: AppTheme(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appTheme});

  final AppTheme appTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messagaty',
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}
