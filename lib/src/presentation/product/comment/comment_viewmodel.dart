import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../resources/repositories/comment.dart';
import 'package:rxdart/rxdart.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class CommentViewModel extends BaseViewModel {
  final CommentResponse response;
  final int productID;

  CommentViewModel({@required this.productID, @required this.response});

  final _controller = BehaviorSubject<TextEditingController>();
  final _isEditing = BehaviorSubject<bool>();
  final _editingSelect = BehaviorSubject<int>();
  final _comments = BehaviorSubject<Comments>();

  Comments get comments => _comments.value;

  set comments(Comments value) {
    _comments.add(value);
    notifyListeners();
  }

  TextEditingController get controller => _controller.value;

  set controller(TextEditingController value) {
    _controller.add(value);
    notifyListeners();
  }

  bool get isEditing => _isEditing.value;

  set isEditing(bool value) {
    _isEditing.add(value);
    notifyListeners();
  }

  int get editingSelect => _editingSelect.value;

  set editingSelect(int value) {
    _editingSelect.add(value);
    notifyListeners();
  }

  Future init(int id) async {
    isLoading = true;

    isEditing = false;
    controller = TextEditingController();
    await fetchComments(id);

    isLoading = false;
  }

  Future fetchComments(int id) async {
    final rs = await response.getComments(id);
    if (rs.statusCode == 200) {
      comments = Comments.fromJson(rs.data);
    }
  }

  Future addComment(int productID) async {
    if (controller.text.isEmpty) return;

    final rs = await response.addComment(productID, controller.text);
    controller.text = '';
    if (rs.statusCode == 200) {
      await fetchComments(productID);
    }
  }

  Future editComment() async {
    if (controller.text.isEmpty || editingSelect == null) return;

    final rs = await response.editComment(editingSelect, controller.text);
    if (rs.statusCode == 200) {
      await fetchComments(productID);
      editingSelect = null;
      isEditing = false;
      controller.text = '';
    }
  }

  Future deleteComment(int id) async {
    final loading = DialogLoading.of(context)..show();

    final rs = await response.deleteComment(id);
    if (rs.statusCode == 200) {
      comments.data.removeWhere((element) => element.id == id);
      notifyListeners();
      Navigator.pop(context);
    }

    loading.hide();
  }

  @override
  Future dispose() async {
    await _controller.drain();
    await _controller.close();
    await _comments.drain();
    await _comments.close();
    return super.dispose();
  }
}
