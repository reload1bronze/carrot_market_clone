import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomeSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '권선구',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<UserProvider>().setUserAuth(false);
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: _bottomeSelectedIndex,
        children: [
          Container(
            color: Colors.accents[0],
          ),
          Container(
            color: Colors.accents[1],
          ),
          Container(
            color: Colors.accents[2],
          ),
          Container(
            color: Colors.accents[3],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomeSelectedIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_bottomeSelectedIndex == 0
                ? 'assets/images/home_selected.png'
                : 'assets/images/home.png')),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_bottomeSelectedIndex == 1
                ? 'assets/images/user_selected.png'
                : 'assets/images/user.png')),
            label: '피드',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_bottomeSelectedIndex == 2
                ? 'assets/images/phone_selected.png'
                : 'assets/images/phone.png')),
            label: '얍',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_bottomeSelectedIndex == 3
                ? 'assets/images/phone_selected.png'
                : 'assets/images/phone.png')),
            label: '얍2',
          ),
        ],
        onTap: (index) {
          setState(() {
            _bottomeSelectedIndex = index;
          });
        },
      ),
    );
  }
}
