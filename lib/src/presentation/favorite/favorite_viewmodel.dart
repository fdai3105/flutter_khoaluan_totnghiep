import 'package:rxdart/rxdart.dart';

import '../../resources/resources.dart';
import '../../utils/utils.dart';
import '../presentation.dart';

class FavoriteViewModel extends BaseViewModel {
  final _favorites = BehaviorSubject<List<ProductDatum>>();

  List<ProductDatum> get favorites => _favorites.value;

  set favorites(List<ProductDatum> value) {
    _favorites.add(value);
    notifyListeners();
  }

  Future init() async {
    isLoading = true;

    favorites = SharedPref.getFavorites();

    isLoading = false;
  }

  @override
  Future dispose() async {
    await _favorites.drain();
    await _favorites.close();
    return super.dispose();
  }
}
