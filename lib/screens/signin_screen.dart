import 'package:flutter/material.dart';

import '../constants/common_size.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);

  final inputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        Size size = MediaQuery.of(context).size;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              '전화번호 로그인',
              style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                    fontSize: 20.0,
                  ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(k_padding),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lock,
                      size: size.width * 0.15,
                    ),
                    SizedBox(
                      width: k_padding_s,
                    ),
                    Text('''당근마켓은 휴대폰 번호로 가입해요.
번호는 안전하게 보관되며,
어디에도 공개되지 않아요.'''),
                  ],
                ),
                SizedBox(
                  height: k_padding,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: inputBorder,
                    focusedBorder: inputBorder,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
