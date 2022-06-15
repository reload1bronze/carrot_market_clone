import 'package:flutter/material.dart';

import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'utils/logger.dart';

void main() {
  logger.v('앱 실행');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
          const Duration(
            seconds: 1,
          ),
          () => 100),
      builder: (context, snapshot) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _splashLoadingWidget(snapshot),
        );
      },
    );
  }

  StatelessWidget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      return const Text('Error occur');
    }
    if (snapshot.hasData) {
      return const MyHomePage();
    }
    return const SplashScreen();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: 'DoHyeon',
        hintColor: Colors.grey[400],
        textTheme: TextTheme(
          headline3: TextStyle(fontFamily: 'DoHyeon'),
          button: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => AuthScreen(),
        '/': (context) => const HomeScreen(),
      },
    );
  }
}
