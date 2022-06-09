import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrot Marget Clone',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<Object>(
          future: Future.delayed(
              const Duration(
                seconds: 1,
              ),
              () => 100),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error occur');
            }
            if (snapshot.hasData) {
              return const MyHomePage();
            }
            return const SplashScreen();
          }),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('바니니'),
      ),
      body: Center(
        child: Column(
          children: [
            ExtendedImage.asset('assets/images/carrot.jpg'),
            Container(height: 200, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
