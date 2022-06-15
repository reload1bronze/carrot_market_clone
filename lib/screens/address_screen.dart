import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintText: '도로명으로 검색',
              hintStyle: TextStyle(color: Theme.of(context).hintColor),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              prefixIconConstraints:
                  BoxConstraints(minWidth: 24, minHeight: 24),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.location_pin,
                  color: Colors.white,
                  size: 20.0,
                ),
                label: Text(
                  '현재 위치 찾기',
                  style: Theme.of(context).textTheme.button,
                ),
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
