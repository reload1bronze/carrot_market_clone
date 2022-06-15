import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import '../constants/common_size.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);

  final inputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  );

  TextEditingController _phoneNumberController =
      TextEditingController(text: '010');

  TextEditingController _codeController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      MaskedInputFormatter('000 0000 0000'),
                    ],
                    decoration: InputDecoration(
                      border: inputBorder,
                      focusedBorder: inputBorder,
                    ),
                    validator: (phoneNumber) {
                      if (phoneNumber != null && phoneNumber.length == 13) {
                        return null;
                      } else {
                        return '휴대폰 번호를 확인해 주시기 바랍니다.';
                      }
                    },
                  ),
                  SizedBox(
                    height: k_padding_s,
                  ),
                  TextButton(
                    onPressed: () {
                      bool passed = _formKey.currentState!.validate();
                    },
                    child: Text('인증문자 발송'),
                  ),
                  SizedBox(
                    height: k_padding,
                  ),
                  TextFormField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      MaskedInputFormatter('000000'),
                    ],
                    decoration: InputDecoration(
                      border: inputBorder,
                      focusedBorder: inputBorder,
                    ),
                  ),
                  SizedBox(
                    height: k_padding_s,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('확인'),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
