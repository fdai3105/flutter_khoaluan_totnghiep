import 'package:flutter/cupertino.dart';

import '../../utils/shared_pref.dart';

import '../../resources/resources.dart';
import 'package:rxdart/rxdart.dart';
import '../presentation.dart';

class UserViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  UserViewModel({@required this.authRepository});

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

  Future submit(String name, int gender) async {
    final user = UserDatum(name: name, gender: gender);
    final response = await authRepository.editUser(user);
    if (response.statusCode == 200) {
      print(response.data);
    } else {
      print(response.data.toString());
    }
  }

  @override
  Future dispose() {
    _user.close();
    return super.dispose();
  }
}
