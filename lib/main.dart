import 'package:flutter/material.dart';

import 'screens/start_screen.dart';
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
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            primary: Colors.white,
            minimumSize: Size(42, 42),
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 2,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => StartScreen(),
        '/': (context) => const HomeScreen(),
      },
    );
  }
}
