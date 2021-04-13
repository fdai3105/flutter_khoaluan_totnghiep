import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khoaluan_totnghiep_mobile/src/configs/configs.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../resources/resources.dart';
import '../../../../utils/utils.dart';
import '../../../presentation.dart';

class EditAddressViewModel extends BaseViewModel {
  final AddressRepository addressRepository;

  EditAddressViewModel({this.addressRepository});

  final _city = BehaviorSubject<City>();
  final _district = BehaviorSubject<District>();
  final _ward = BehaviorSubject<Ward>();
  final _address = BehaviorSubject<String>();

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

  Future init(AddressDatum addressDatum) async {
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
    }
  }

  Future addAddress() async {
    if (city == null || district == null || ward == null || address == null) {
      return;
    }
    final data = AddressDatum(
      city: cityName,
      district: districtName,
      ward: wardName,
      address: address,
    );
    final result =
        await addressRepository.addAddress(data, SharedPref.getToken());
    if (result.statusCode == 200) {
      Navigator.pop(context);
    } else {
      print(result.data);
    }
  }

  Future deleteAddress(int id) async {
    final dl = DialogLoading.of(context)..show();
    final repo = await addressRepository.deleteAddress(id);
    dl.hide();

    if (repo.statusCode == 200) {
      Navigator.pop(context);
    } else {
      Get.rawSnackbar(message: 'Something error, please try again.isBlank');
    }
  }

  @override
  Future dispose() {
    _city.close();
    _district.close();
    _ward.close();
    return super.dispose();
  }
}
