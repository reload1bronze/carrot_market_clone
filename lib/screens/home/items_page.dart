import 'package:carrot_market_clone/constants/common_size.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        final imgSize = size.width / 4;

        return ListView.separated(
          padding: EdgeInsets.all(k_padding),
          separatorBuilder: (context, index) {
            return Divider(
              height: k_padding * 2 + 1,
              thickness: 1,
              color: Colors.grey[300],
              indent: k_padding_s,
              endIndent: k_padding_s,
            );
          },
          itemBuilder: (context, index) {
            return SizedBox(
              height: imgSize,
              child: Row(
                children: [
                  SizedBox(
                    height: imgSize,
                    width: imgSize,
                    child: ExtendedImage.network(
                      'https://picsum.photos/100',
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  SizedBox(
                    width: k_padding_s,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'work',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          '53일전',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text('5,000원'),
                        Expanded(
                          child: Container(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 14,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.chat_bubble,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      '123',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    Icon(
                                      Icons.heart_broken,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      '123',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: 10,
        );
      },
    );
  }
}
