import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/user_provider.dart';
import 'screens/start_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'utils/logger.dart';

void main() {
  logger.v('앱 실행');
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  final Future<FirebaseApp> _initiralization = Firebase.initializeApp();
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initiralization,
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
    if (snapshot.connectionState == ConnectionState.done) {
      return const MyHomePage();
    }
    return const SplashScreen();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (BuildContext context) {
        return UserProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          fontFamily: 'DoHyeon',
          hintColor: Colors.grey[400],
          textTheme: TextTheme(
            headline3: TextStyle(fontFamily: 'DoHyeon'),
            button: TextStyle(color: Colors.white),
            subtitle1: TextStyle(
              color: Colors.black87,
              fontSize: 15,
            ),
            subtitle2: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
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
            actionsIconTheme: IconThemeData(
              color: Colors.black87,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.black87,
            unselectedItemColor: Colors.black26,
          ),
        ),
        initialRoute: '/start',
        routes: {
          '/start': (context) => StartScreen(),
          '/': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
