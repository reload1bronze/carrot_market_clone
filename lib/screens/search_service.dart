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

  Future<void> findAddressByCoords(
      {required double? lat, required double? long}) async {
    final Map<String, dynamic> formData = {
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'GetAddress',
      'type': 'BOTH',
      'point': '$long,$lat',
    };

    final response = await Dio()
        .get('http://api.vworld.kr/req/address', queryParameters: formData)
        .catchError((e) {
      logger.e(e.message);
    });

    logger.d(response);
    return;
  }
}
