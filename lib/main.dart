import 'package:flutter/material.dart';
import 'package:flutter_billiard/providers/setting_provider.dart';
import 'package:flutter_billiard/providers/timermodel_provider.dart';
import 'package:flutter_billiard/screens/home_screen.dart';
import 'package:flutter_billiard/screens/setting_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Setting()),
        ChangeNotifierProvider(create: (_) => TimerModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/settings': (context) => const SettingScreen(),
      },
    );
  }
}


