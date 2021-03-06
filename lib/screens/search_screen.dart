import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/address_model.dart';
import '../data/address_model2.dart';
import '../utils/logger.dart';
import 'search_service.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();

  AddressModel? _addressModel;
  List<AddressModel2> _addressModel2List = [];
  bool _isGettingLocation = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _searchController,
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
            onFieldSubmitted: (text) async {
              _addressModel2List.clear();
              _addressModel = await SearchService().searchAddressByStr(text);
              logger.d(_addressModel);
              setState(() {});
            },
          ),
          TextButton.icon(
            icon: _isGettingLocation
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(color: Colors.white))
                : Icon(
                    Icons.location_pin,
                    color: Colors.white,
                    size: 20.0,
                  ),
            label: Text(
              _isGettingLocation ? '위치 찾는 중...' : '현재 위치 찾기',
              style: Theme.of(context).textTheme.button,
            ),
            style: TextButton.styleFrom(
              minimumSize: Size(10, 36),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: () async {
              _addressModel = null;
              _addressModel2List.clear();
              setState(() {
                _isGettingLocation = true;
              });

              Location location = new Location();

              bool _serviceEnabled;
              PermissionStatus _permissionGranted;
              LocationData _locationData;

              _serviceEnabled = await location.serviceEnabled();
              if (!_serviceEnabled) {
                _serviceEnabled = await location.requestService();
                if (!_serviceEnabled) {
                  return;
                }
              }

              _permissionGranted = await location.hasPermission();
              if (_permissionGranted == PermissionStatus.denied) {
                _permissionGranted = await location.requestPermission();
                if (_permissionGranted != PermissionStatus.granted) {
                  return;
                }
              }

              _locationData = await location.getLocation();
              logger.d(_locationData);
              List<AddressModel2> addresses = await SearchService()
                  .findAddressByCoords(
                      lat: _locationData.latitude,
                      long: _locationData.longitude);

              _addressModel2List.addAll(addresses);

              setState(() {
                _isGettingLocation = false;
              });
            },
          ),
          if (_addressModel != null)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                itemBuilder: (context, index) {
                  if (_addressModel == null ||
                      _addressModel!.result == null ||
                      _addressModel!.result!.items == null ||
                      _addressModel!.result!.items![index].address == null) {
                    return Container(
                      child: Text('없어'),
                    );
                  }
                  return ListTile(
                    title: Text(
                        _addressModel!.result!.items![index].address!.road ??
                            ''),
                    subtitle: Text(
                        _addressModel!.result!.items![index].address!.parcel ??
                            ''),
                    onTap: () {
                      _saveAddressAndGoToNextPage(
                          _addressModel!.result!.items![index].address!.road ??
                              '');
                      context.read<PageController>().animateToPage(
                            1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                    },
                  );
                },
                itemCount: _addressModel?.result?.items?.length ?? 0,
              ),
            ),
          if (_addressModel2List.isNotEmpty)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                itemBuilder: (context, index) {
                  if (_addressModel2List[index].result == null ||
                      _addressModel2List[index].result!.isEmpty) {
                    return Container(
                      child: Text('없어'),
                    );
                  }
                  return ListTile(
                    title:
                        Text(_addressModel2List[index].result![0].text ?? ''),
                    subtitle: Text(
                        _addressModel2List[index].result![0].zipcode ?? ''),
                    onTap: () {
                      _saveAddressAndGoToNextPage(
                          _addressModel2List[index].result![0].text ?? '');
                    },
                  );
                },
                itemCount: _addressModel2List.length,
              ),
            ),
        ],
      ),
    );
  }

  _saveAddressAndGoToNextPage(String address) async {
    await _saveAddressOnSharedPreferences(address);
    context.read<PageController>().animateToPage(
          2,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
  }

  _saveAddressOnSharedPreferences(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', address);
  }
}
