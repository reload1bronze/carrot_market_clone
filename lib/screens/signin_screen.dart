import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';

import '../constants/common_size.dart';
import '../providers/user_provider.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final inputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  );

  TextEditingController _phoneNumberController =
      TextEditingController(text: '010');

  TextEditingController _codeController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerificationStatus _verificationStatus = VerificationStatus.none;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        Size size = MediaQuery.of(context).size;

        return IgnorePointer(
          ignoring: _verificationStatus == VerificationStatus.verifying,
          child: Scaffold(
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
                        if (passed) {
                          setState(() {
                            _verificationStatus = VerificationStatus.codeSent;
                          });
                        }
                      },
                      child: Text('인증문자 발송'),
                    ),
                    SizedBox(
                      height: k_padding,
                    ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      opacity: getVerificationOpacity(_verificationStatus),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
                            onPressed: () {
                              attemptVerify();
                            },
                            child: (_verificationStatus ==
                                    VerificationStatus.verifying)
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text('확인'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  double getVerificationOpacity(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 1;
    }
  }

  void attemptVerify() async {
    setState(() {
      _verificationStatus = VerificationStatus.verifying;
    });
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      _verificationStatus = VerificationStatus.verificationDone;
    });
    context.read<UserProvider>().setUserAuth(true);
  }
}

enum VerificationStatus { none, codeSent, verifying, verificationDone }
