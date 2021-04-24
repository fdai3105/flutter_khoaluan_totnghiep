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
    await fetchComments(id);
    isLoading = false;
  }

  Future fetchComments(int id) async {
    final com = await productResponse.getCommentsByProduct(id);
    if (com.statusCode == 200) {
      comments = Comments.fromJson(com.data);
    }
  }

  Future addComment(int productID, String comment) async {
    final addCommentResponse =
        await productResponse.addComment(productID, comment);
    if (addCommentResponse.statusCode == 200) {
      await fetchComments(productID);
    } else {
      print(addCommentResponse.data);
    }
  }

  @override
  Future dispose() {
    _comments.close();
    return super.dispose();
  }
}
