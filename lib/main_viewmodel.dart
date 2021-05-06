import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import 'src/configs/configs.dart';
import 'src/presentation/presentation.dart';
import 'src/utils/utils.dart';

class MainViewModel extends BaseViewModel {
  final _darkMode = BehaviorSubject<bool>();
  final _language = BehaviorSubject<Language>();

  bool get darkMode => _darkMode.value;

  set darkMode(bool value) {
    _darkMode.add(value);
    SharedPref.setDarkMode(value: value);
    notifyListeners();
  }

  Language get language => _language.value;

  set language(Language value) {
    _language.add(value);
    SharedPref.setLanguage(language);
    Get.updateLocale(AppTranslations.getLocale(language));
    notifyListeners();
  }

  Future init() async {
    isLoading = true;

    darkMode = SharedPref.isDarkMode();
    language = SharedPref.getLanguage();

    isLoading = false;
  }

  @override
  Future dispose() {
    _darkMode.close();
    _language.close();
    return super.dispose();
  }
}
