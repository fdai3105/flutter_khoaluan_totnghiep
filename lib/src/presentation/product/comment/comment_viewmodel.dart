import 'package:rxdart/rxdart.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class CommentViewModel extends BaseViewModel {
  final ProductResponse productResponse;

  CommentViewModel({this.productResponse});

  final _comments = BehaviorSubject<Comments>();

  Comments get comments => _comments.value;

  set comments(Comments value) {
    _comments.add(value);
    notifyListeners();
  }

  Future init(int id) async {
    isLoading = true;

    final com = await productResponse.getCommentsByProduct(id);
    if (com.statusCode == 200) {
      comments = Comments.fromJson(com.data);
    }

    isLoading = false;
  }

  @override
  Future dispose() {
    _comments.close();
    return super.dispose();
  }
}
