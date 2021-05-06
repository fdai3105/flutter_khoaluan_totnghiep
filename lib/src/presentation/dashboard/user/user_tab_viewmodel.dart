import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:rxdart/rxdart.dart';

import '../../../resources/resources.dart';
import '../../../utils/utils.dart';
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
