import 'package:khoaluan_totnghiep_mobile/src/utils/shared_pref.dart';

import '../../resources/resources.dart';
import 'package:rxdart/rxdart.dart';
import '../presentation.dart';

class UserViewModel extends BaseViewModel {
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

  @override
  Future dispose() {
    _user.close();
    return super.dispose();
  }
}
