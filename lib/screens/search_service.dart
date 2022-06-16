import 'package:carrot_market_clone/constants/keys.dart';
import 'package:dio/dio.dart';

import '../data/address_model.dart';
import '../utils/logger.dart';

class SearchService {
  Future<AddressModel> searchAddressByStr(String text) async {
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

    logger.v(response);
    AddressModel addressModel =
        AddressModel.fromJson(response.data['response']);
    logger.v(addressModel);
    return addressModel;
  }
}
