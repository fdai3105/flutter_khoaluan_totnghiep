// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import '../../../resources/resources.dart';
import '../../presentation.dart';

class CategoryTabViewModel extends BaseViewModel {
  final CategoryResponse response;

  CategoryTabViewModel({this.response});

  final _categories = BehaviorSubject<Category>();

  Category get categories => _categories.value;

  set categories(Category value) {
    _categories.add(value);
    notifyListeners();
  }

  Future init() async {
    isLoading = true;

    final categoryData = await response.getParentCategories();
    if (categoryData.statusCode == 200) {
      categories = Category.fromJson(categoryData.data);
    }

    isLoading = false;
  }

  @override
  Future dispose() {
    _categories.close();
    return super.dispose();
  }
}
