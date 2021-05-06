// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import '../../../resources/resources.dart';
import '../../../utils/utils.dart';
import '../../presentation.dart';

class CheckoutViewModel extends BaseViewModel {
  final OrderRepository orderRepository;
  final AddressRepository addressRepository;

  CheckoutViewModel({this.orderRepository, this.addressRepository});

  final _address = BehaviorSubject<Address>();
  final _selectedAddress = BehaviorSubject<int>();
  final _note = BehaviorSubject<String>();

  Address get address => _address.value;

  set address(Address value) {
    _address.add(value);
    notifyListeners();
  }

  int get selectedAddress => _selectedAddress.value;

  set selectedAddress(int value) {
    _selectedAddress.add(value);
    notifyListeners();
  }

  String get note => _note.value;

  set note(String value) {
    _note.add(value);
    notifyListeners();
  }

  Future init() async {
    isLoading = true;

    await _fetchAddress();

    isLoading = false;
  }

  Future _fetchAddress() async {
    final repo = await addressRepository.getAddress(SharedPref.getToken());
    if (repo.statusCode == 200) {
      address = Address.fromJson(repo.data);
    }
  }

  AddressDatum getSelectedAddress() {
    if (address == null) return null;
    if (address.data.isEmpty) return null;

    if (address.data.length == 1 || selectedAddress == null) {
      return address.data.first;
    }
    return address.data.firstWhere((element) => element.id == selectedAddress);
  }

  Future checkout() async {
    if (getSelectedAddress() == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select your address')));
      return;
    }
    final dlLoading = DialogLoading.of(context)..show();
    final repo = await orderRepository.checkout(
        SharedPref.getCarts(), note ?? "note", getSelectedAddress().id);
    if (repo.statusCode == 200) {
      await SharedPref.removeCarts();
      await Navigator.pushReplacementNamed(context, Routes.orderSuccess);
    } else {
      print(repo.data);
    }
    dlLoading.hide();
  }

  @override
  Future dispose() async {
    await _address.drain();
    await _address.close();
    await _address.drain();
    await _selectedAddress.close();
    return super.dispose();
  }
}
