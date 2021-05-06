// Package imports:
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import '../../resources/resources.dart';
import '../../utils/utils.dart';
import '../presentation.dart';

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

  Future toAddAddress() async {
    final dl = DialogLoading.of(context)..show();
    final isVerifiedEmail = await AuthRepository.hasVerifiedEmail();
    dl.hide();

    await pushNewScreen(
      context,
      screen: isVerifiedEmail ? AddAddressScreen() : ResendMailScreen(),
    ).then((value) => init());
  }

  @override
  Future dispose() async {
    await _address.drain();
    await _address.close();
    return super.dispose();
  }
}
