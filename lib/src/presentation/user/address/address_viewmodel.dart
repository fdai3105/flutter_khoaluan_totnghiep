import 'package:rxdart/rxdart.dart';
import '../../../resources/repositories/address.dart';
import '../../../utils/shared_pref.dart';
import '../../../resources/models/models.dart';
import '../../base/base.dart';

class AddressViewModel extends BaseViewModel {
  final AddressRepository addressRepository;

  AddressViewModel({this.addressRepository});

  final _address = BehaviorSubject<Address>();

  Address get address => _address.value;

  set address(Address value) {
    _address.add(value);
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

  @override
  Future dispose() {
    _address.close();
    return super.dispose();
  }
}
