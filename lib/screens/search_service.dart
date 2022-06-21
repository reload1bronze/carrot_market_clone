import 'package:carrot_market_clone/constants/keys.dart';
import 'package:dio/dio.dart';

import '../data/address_model.dart';
import '../data/address_model2.dart';
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

  Future<List<AddressModel2>> findAddressByCoords(
      {required double? lat, required double? long}) async {
    final List<Map<String, dynamic>> formDatas = <Map<String, dynamic>>[];

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'GetAddress',
      'type': 'PARCEL',
      'point': '${long! - 0.01},$lat',
    });

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'GetAddress',
      'type': 'PARCEL',
      'point': '$long,${lat! - 0.01}',
    });

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'GetAddress',
      'type': 'PARCEL',
      'point': '$long,$lat',
    });

    List<AddressModel2> addresses = [];

    for (Map<String, dynamic> formData in formDatas) {
      final response = await Dio()
          .get('http://api.vworld.kr/req/address', queryParameters: formData)
          .catchError((e) {
        logger.e(e.message);
      });

      AddressModel2 addressModel =
          AddressModel2.fromJson(response.data['response']);

      if (response.data['response']['status'] == 'OK') {
        addresses.add(addressModel);
      }
    }

    return addresses;
  }
}
