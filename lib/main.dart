import 'package:flutter/material.dart';
import 'package:billiards_countdown/providers/timermodel_provider.dart';
import 'package:billiards_countdown/screens/home_screen.dart';
import 'package:billiards_countdown/screens/setting_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  TimerModel timerModel = TimerModel();
  await timerModel.initValues();
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: timerModel),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/settings': (context) => const SettingScreen(),
      },
    );
  }
}
