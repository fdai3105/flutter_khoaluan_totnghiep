import 'src/utils/shared_pref.dart';
import 'package:rxdart/rxdart.dart';

import 'src/presentation/base/base.dart';

class MainViewModel extends BaseViewModel {
  final _darkMode = BehaviorSubject<bool>();

  bool get darkMode => _darkMode.value;

  set darkMode(bool value) {
    _darkMode.add(value);
    SharedPref.setDarkMode(value: value);
    notifyListeners();
  }

  Future init() async {
    isLoading = true;

    darkMode = SharedPref.isDarkMode();

    isLoading = false;
  }
}
