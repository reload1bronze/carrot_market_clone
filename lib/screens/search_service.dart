import 'package:carrot_market_clone/constants/keys.dart';
import 'package:dio/dio.dart';

import '../utils/logger.dart';

class SearchService {
  void searchAddressByStr(String text) async {
    final formData = {
      'key': VWORLD_KEY,
      'request': 'search',
      'type': 'ADDRESS',
      'category': 'ROAD',
      'query': text,
      'size': '20',
    };

    final response = await Dio()
        .get('http://api.vworld.kr/req/search', queryParameters: formData)
        .catchError((e) {
      logger.e(e.message);
    });
    
    logger.d(response);
  }
}
