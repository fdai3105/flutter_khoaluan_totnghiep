import 'package:khoaluan_totnghiep_mobile/src/resources/resources.dart';
import 'package:khoaluan_totnghiep_mobile/src/utils/shared_pref.dart';
import 'package:rxdart/rxdart.dart';

import '../../presentation.dart';

class CheckoutViewModel extends BaseViewModel {
  final AddressRepository addressRepository;

  CheckoutViewModel({this.addressRepository});

  final _address = BehaviorSubject<Address>();
  final _selectedAddress = BehaviorSubject<int>();

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
    if(address.data.isEmpty) {
      return null;
    }
    if (address.data.length == 1 || selectedAddress == null) {
      return address.data.first;
    }
    return address.data.firstWhere((element) => element.id == selectedAddress);
  }

  @override
  Future dispose() {
    _address.close();
    _selectedAddress.close();
    return super.dispose();
  }
}
