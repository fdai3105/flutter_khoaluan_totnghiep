import '../../../resources/repositories/product.dart';
import '../../../resources/resources.dart';
import 'package:rxdart/rxdart.dart';
import '../../presentation.dart';

class RatingViewModel extends BaseViewModel {
  final ProductResponse productResponse;

  RatingViewModel({this.productResponse});

  final _rating = BehaviorSubject<Ratings>();

  Ratings get ratings => _rating.value;

  double get sumRating => calcTotal();

  int get countRating => ratings.data.isEmpty ? 0 : ratings.data.length;

  set ratings(Ratings value) {
    _rating.add(value);
    notifyListeners();
  }

  Future init(int id) async {
    isLoading = true;

    final ratingsRepo = await productResponse.getRatingsByProduct(id);
    if (ratingsRepo.statusCode == 200) {
      ratings = Ratings.fromJson(ratingsRepo.data);
    }

    isLoading = false;
  }

  double calcTotal() {
    if (ratings.data.isEmpty) {
      return 0;
    }
    var total = 0;
    for (final item in ratings.data) {
      total += item.rating;
    }
    return (total / ratings.data.length).roundToDouble();
  }

  @override
  Future dispose() {
    _rating.close();
    return super.dispose();
  }
}
