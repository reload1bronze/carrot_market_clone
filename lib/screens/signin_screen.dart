import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '회원가입',
          style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
