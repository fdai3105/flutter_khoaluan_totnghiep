import 'package:flutter/cupertino.dart';

import '../../resources/resources.dart';

import '../presentation.dart';

class RegisterViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  RegisterViewModel({@required this.authRepository});

  void init() {}

  Future register(String name, String email, String phone, String password,
      int gender) async {
    isLoading = true;
    final user = await authRepository.register(name, email, phone, password,gender);
    print(user.toString());
    isLoading = true;
  }
}
