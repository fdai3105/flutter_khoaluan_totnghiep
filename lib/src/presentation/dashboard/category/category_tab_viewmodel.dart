import 'package:rxdart/rxdart.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class CategoryTabViewModel extends BaseViewModel {
  final CategoryResponse categoryResponse;

  CategoryTabViewModel({this.categoryResponse});

  final _categories = BehaviorSubject<Categories>();

  Categories get categories => _categories.value;

  set categories(Categories value) {
    _categories.add(value);
    notifyListeners();
  }

  Future init() async {
    isLoading = true;

    final categoryData = await categoryResponse.getParentCategories();
    if (categoryData.statusCode == 200) {
      categories = Categories.fromJson(categoryData.data);
    }

    isLoading = false;
  }

  @override
  Future dispose() {
    _categories.close();
    return super.dispose();
  }
}
