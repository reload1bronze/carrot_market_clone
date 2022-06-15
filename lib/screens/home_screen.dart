import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<UserProvider>().setUserAuth(false);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ExtendedImage.asset('assets/images/carrot.jpg'),
          ],
        ),
      ),
    );
  }
}
