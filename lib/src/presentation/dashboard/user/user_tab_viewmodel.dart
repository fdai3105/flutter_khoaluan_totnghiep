import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rxdart/rxdart.dart';
import '../../../utils/utils.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class UserTabViewModel extends BaseViewModel {
  final _user = BehaviorSubject<User>();

  User get user => _user.value;

  set user(User value) {
    _user.add(value);
    notifyListeners();
  }

  Future init() async {
    isLoading = true;

    user = SharedPref.getUser();

    isLoading = false;
  }

  Future toOrderScreen() async {
    final dl = DialogLoading.of(context)..show();
    final isVerifiedEmail = await AuthRepository.hasVerifiedEmail();
    dl.hide();

    await pushNewScreen(
      context,
      screen: isVerifiedEmail ? OrderScreen() : ResendMailScreen(),
      withNavBar: false,
    );
  }

  Future logout() async {
    await SharedPref.clear();
    Phoenix.rebirth(context);
  }

  @override
  Future dispose() {
    _user.close();
    return super.dispose();
  }
}
