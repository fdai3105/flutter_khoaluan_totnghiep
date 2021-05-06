// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import '../../../resources/resources.dart';
import '../../../utils/utils.dart';
import '../../presentation.dart';

class AddAddressViewModel extends BaseViewModel {
  final AddressRepository addressRepository;

  AddAddressViewModel({this.addressRepository});

  final _city = BehaviorSubject<City>();
  final _district = BehaviorSubject<District>();
  final _ward = BehaviorSubject<Ward>();
  final _address = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();
  final _phone = BehaviorSubject<String>();

  City get city => _city.value;

  String get cityName {
    if (city != null) {
      return city.name;
    }
    return null;
  }

  set city(City value) {
    _city.add(value);
    notifyListeners();
  }

  District get district => _district.value;

  String get districtName {
    if (district != null) {
      return district.nameWithType;
    }
    return null;
  }

  set district(District value) {
    _district.add(value);
    notifyListeners();
  }

  Ward get ward => _ward.value;

  String get wardName {
    if (ward != null) {
      return ward.nameWithType;
    }
    return null;
  }

  set ward(Ward value) {
    _ward.add(value);
    notifyListeners();
  }

  String get address => _address.value;

  set address(String value) {
    _address.add(value);
    notifyListeners();
  }

  String get name => _name.value;

  set name(String value) {
    _name.add(value);
    notifyListeners();
  }

  String get phone => _phone.value;

  set phone(String value) {
    _phone.add(value);
    notifyListeners();
  }

  Future init() async {
    isLoading = true;

    isLoading = false;
  }

  Future onCitySelected() async {
    final routes = await Navigator.pushNamed(context, Routes.city);
    if (routes != null) {
      city = routes as City;
    }
  }

  Future onDistrictSelected() async {
    if (city != null) {
      final routes = await pushNewScreen(
        context,
        screen: DistrictScreen(cityID: city.code),
      );
      if (routes != null) {
        district = routes as District;
      }
    } else {
      snackBar(context, 'city_null'.tr);
    }
  }

  Future onWardSelected() async {
    if (district != null) {
      final routes = await pushNewScreen(
        context,
        screen: WardScreen(districtID: district.code),
      );
      if (routes != null) {
        ward = routes as Ward;
      }
    } else {
      snackBar(context, 'district_null'.tr);
    }
  }

  Future addAddress() async {
    if (name == null ||
        phone == null ||
        city == null ||
        district == null ||
        ward == null ||
        address == null) {
      snackBar(context, 'input_null'.tr);
      return;
    }
    final data = AddressDatum(
      name: name,
      phone: phone,
      city: cityName,
      district: districtName,
      ward: wardName,
      address: address,
    );
    final result =
        await addressRepository.addAddress(data, SharedPref.getToken());
    if (result.statusCode == 200) {
      Navigator.pop(context);
    }
  }

  @override
  Future dispose() {
    _city.close();
    _district.close();
    _ward.close();
    _address.close();
    _name.close();
    _phone.close();
    return super.dispose();
  }
}
