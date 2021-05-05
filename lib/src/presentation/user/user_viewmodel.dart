import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../utils/shared_pref.dart';

import '../../resources/resources.dart';
import 'package:rxdart/rxdart.dart';
import '../presentation.dart';

class UserViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  UserViewModel({@required this.authRepository});

  final _user = BehaviorSubject<User>();
  final _avatar = BehaviorSubject<File>();

  User get user => _user.value;

  set user(User value) {
    _user.add(value);
    notifyListeners();
  }

  File get avatar => _avatar.value;

  set avatar(File value) {
    _avatar.add(value);
    notifyListeners();
  }

  Future init() async {
    isLoading = true;

    user = SharedPref.getUser();

    isLoading = false;
  }

  Future submit(String name, int gender) async {
    final loading = DialogLoading.of(context)..show();

    final user = UserDatum(name: name, gender: gender);
    final response = await authRepository.editUser(user, avatar);
    if (response.statusCode == 200) {
      await SharedPref.updatedUser(UserDatum.fromJson(response.data['data']));
      Phoenix.rebirth(context);
    }

    loading.hide();
  }

  @override
  Future dispose() async {
    await _user.drain();
    await _user.close();
    await _avatar.drain();
    await _avatar.close();
    return super.dispose();
  }
}
