import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../../utils/utils.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class RegisterViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  RegisterViewModel({@required this.authRepository});

  final _pageIndex = BehaviorSubject<int>();

  int get pageIndex => _pageIndex.value;

  set pageIndex(int value) {
    _pageIndex.add(value);
    notifyListeners();
  }

  final _pageController = BehaviorSubject<PageController>();
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _phone = BehaviorSubject<String>();
  final _gender = BehaviorSubject<int>();
  final _password = BehaviorSubject<String>();
  final _passwordConfirm = BehaviorSubject<String>();

  PageController get pageController => _pageController.value;

  set pageController(PageController value) {
    _pageController.add(value);
    notifyListeners();
  }

  String get name => _name.value;

  set name(String value) {
    _name.add(value);
    notifyListeners();
  }

  String get email => _email.value;

  set email(String value) {
    _email.add(value);
    notifyListeners();
  }

  String get phone => _phone.value;

  set phone(String value) {
    _phone.add(value);
    notifyListeners();
  }

  String get password => _password.value;

  set password(String value) {
    _password.add(value);
    notifyListeners();
  }

  String get passwordConfirm => _passwordConfirm.value;

  set passwordConfirm(String value) {
    _passwordConfirm.add(value);
    notifyListeners();
  }

  int get gender => _gender.value;

  set gender(int value) {
    _gender.add(value);
    notifyListeners();
  }

  void init() {
    isLoading = false;

    pageController = PageController();
    pageIndex = 0;

    isLoading = true;
  }

  double percent() {
    var percent = 0.0;
    final t = 1 / RegisterScreen().bodies(context,  this).length;
    percent = t * pageIndex;
    return percent + t;
  }

  void nextPage() {
    switch (pageIndex) {
      case 0:
        if (name == null) {
          snackBar(context, 'Please enter your first and last name');
          return;
        }
        break;
      case 1:
        if (email == null) {
          snackBar(context, 'Please enter a valid email address');
          return;
        }
        break;
      case 2:
        if (phone == null) {
          snackBar(context, 'Please enter a valid mobile number');
        }
        break;
      case 3:
        if (gender == null) {
          snackBar(context, 'Please select your gender');
          return;
        }
        break;
      case 4:
        if (password == null || passwordConfirm == null) {
          snackBar(context,
              'Your password must have at least 6 letters, numbers and symbols.');
          return;
        } else {
          if (password != passwordConfirm) {
            snackBar(context, 'Your confirm password mush match password');
            return;
          }
        }
        break;
      case 5:
        register();
        return;
        break;
    }

    pageController.nextPage(
      curve: Curves.linear,
      duration: const Duration(milliseconds: 200),
    );
  }

  Future register() async {
    final dialog = DialogLoading.of(context)..show();
    final userRepo =
        await authRepository.register(name, email, phone, password, gender);
    dialog.hide();

    if (userRepo.statusCode == 200) {
      Navigator.pop(context);
    } else if (userRepo.statusCode == 422) {
      var msg = '';
      Map.from(userRepo.data['errors']).forEach((key, value) {
        msg +=
            '${value.toString().substring(1, value.toString().length - 1)}\n';
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg.substring(0, msg.length - 1))));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(userRepo.data)));
    }
  }

  @override
  Future dispose() {
    _pageController.close();
    _name.close();
    _email.close();
    _password.close();
    _gender.close();
    return super.dispose();
  }
}
