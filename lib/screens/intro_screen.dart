import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../utils/logger.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '당근마켓',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Stack(
              children: [
                ExtendedImage.asset('assets/images/map.jpg'),
                Positioned(
                  child: Icon(Icons.abc),
                ),
              ],
            ),
            Text(
              '우리 동네 중고 직거래 당근마켓',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '''당근마켓은 동네 직거래 마켓이에요.
            내 동네를 설정하고 시작해보세요.''',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  child: Text(
                    '내 동네 설정하고 시작하기',
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () {
                    logger.d('버튼클릭');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
