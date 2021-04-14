import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rxdart/rxdart.dart';
import '../../../resources/repositories/address.dart';
import '../../../utils/shared_pref.dart';
import '../../../resources/resources.dart';
import '../../base/base.dart';
import '../../presentation.dart';

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
  Future dispose() {
    _address.close();
    return super.dispose();
  }
}
