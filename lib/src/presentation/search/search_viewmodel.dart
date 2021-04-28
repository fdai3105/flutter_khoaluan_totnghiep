import 'package:rxdart/rxdart.dart';
import '../../resources/resources.dart';
import '../presentation.dart';

class SearchViewModel extends BaseViewModel {
  final ProductResponse productResponse;

  SearchViewModel({this.productResponse}) {
    _keyWord
        .debounceTime(const Duration(milliseconds: 500))
        .listen((event) async {
      await _onSearching(event);
    });
  }

  final _keyWord = BehaviorSubject<String>();
  final _result = BehaviorSubject<Products>();
  final _isSearching = BehaviorSubject<bool>();

  Products get result => _result.value;

  set result(Products value) {
    _result.add(value);
    notifyListeners();
  }

  bool get isSearching => _isSearching.value;

  set isSearching(bool value) {
    _isSearching.add(value);
    notifyListeners();
  }

  String get keyWord => _keyWord.value;

  set keyWord(String value) {
    _keyWord.add(value);
    notifyListeners();
  }

  Future init() async {
    isLoading = true;
    isSearching = false;
    isLoading = false;
  }

  Future _onSearching(String keyWord) async {
    isLoading = true;
    if (keyWord.isNotEmpty) {
      final resultRepo = await productResponse.searchProduct(keyWord);
      if (resultRepo.statusCode == 200) {
        result = Products.fromJson(resultRepo.data);
      }
    } else {
      result = null;
    }
    isLoading = false;
  }

  @override
  Future dispose() {
    _keyWord.close();
    _result.close();
    _isSearching.close();
    return super.dispose();
  }
}
