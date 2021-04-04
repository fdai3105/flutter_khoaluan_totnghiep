import 'package:flutter/material.dart';

import '../../../resources/repositories/address.dart';
import '../../../utils/shared_pref.dart';

import '../../../resources/models/models.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/base.dart';

class AddressViewModel extends BaseViewModel {
  final AddressRepository addressRepository;

  AddressViewModel({this.addressRepository});

  final _address = BehaviorSubject<Address>();
  final _city = BehaviorSubject<String>();
  final _district = BehaviorSubject<String>();
  final _ward = BehaviorSubject<String>();

  Address get address => _address.value;

  set address(Address value) {
    _address.add(value);
    notifyListeners();
  }

  String get city => _city.value;

  set city(String value) {
    _city.add(value);
    notifyListeners();
  }

  String get district => _district.value;

  set district(String value) {
    _district.add(value);
    notifyListeners();
  }

  String get ward => _ward.value;

  set ward(String value) {
    _ward.add(value);
    notifyListeners();
  }

  Future init() async {
    isLoading = true;

    final addressRepo =
        await addressRepository.getAddress(SharedPref.getToken());
    if (addressRepo.statusCode == 200) {
      address = Address.fromJson(addressRepo.data);
    }

    isLoading = false;
  }

  Future addAddress(AddressDatum address) async {
    final result =
        await addressRepository.addAddress(address, SharedPref.getToken());
    if (result.statusCode == 200) {
      Navigator.pop(context);
    } else {
      print(result.data);
    }
  }

  @override
  Future dispose() {
    _address.close();
    _district.close();
    _ward.close();
    return super.dispose();
  }
}
