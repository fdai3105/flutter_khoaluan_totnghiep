// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:rxdart/rxdart.dart';

class BaseViewModel extends ChangeNotifier {
  BuildContext context;

  final _loadSubject = BehaviorSubject<bool>();

  bool get isLoading => _loadSubject.value;

  set isLoading(bool value) {
    _loadSubject.add(value);
    notifyListeners();
  }

  @override
  Future dispose() async {
    await _loadSubject.drain();
    await _loadSubject.close();
    super.dispose();
  }
}
