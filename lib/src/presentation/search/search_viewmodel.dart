import '../../resources/resources.dart';
import 'package:rxdart/rxdart.dart';

import '../presentation.dart';

class SearchViewModel extends BaseViewModel {
  final ProductResponse productResponse;

  SearchViewModel({this.productResponse});

  final _result = BehaviorSubject<Products>();

  Products get result => _result.value;

  set result(Products value) {
    _result.add(value);
    notifyListeners();
  }

  Future init() async {
    isLoading = true;

    isLoading = false;
  }

  Future onSearching(String keyWord) async {
    final resultRepo = await productResponse.searchProduct(keyWord);
    if(resultRepo.statusCode == 200) {
      result = Products.fromJson(resultRepo.data);
    }
  }

  @override
  Future dispose() {
    _result.close();
    return super.dispose();
  }
}
