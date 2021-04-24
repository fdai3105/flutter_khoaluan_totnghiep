import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../presentation.dart';
import '../../../resources/resources.dart';
import '../../../configs/configs.dart';

class CommentDialog extends StatelessWidget {
  final int productId;

  const CommentDialog({Key key, this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetAppBar(title: 'Comments'),
      body: SafeArea(
        child: BaseWidget<CommentViewModel>(
          viewModel: CommentViewModel(
            productID: productId,
            response: CommentResponse(),
          ),
          onViewModelReady: (vm) async {
            await vm.init(productId);
          },
          builder: (context, vm, widget) {
            return Column(
              children: [
                Expanded(child: _body(vm)),
                _field(vm),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _body(CommentViewModel vm) {
    if (vm.isLoading) {
      return WidgetLoading();
    }
    if (vm.comments.data.isEmpty) {
      return const Center(child: Text('No comment yet'));
    }
    return SingleChildScrollView(
      child: _listComments(vm.comments.data, vm),
    );
  }

  Widget _field(CommentViewModel vm) {
    return Row(
      children: [
        Expanded(
          child: WidgetTextField(
            controller: vm.controller,
            hint: 'Write a comment',
            onChanged: (value) {},
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send, color: AppColors.primary),
          onPressed: () {
            vm.isEditing ? vm.editComment() : vm.addComment(productId);
          },
        ),
      ],
    );
  }

  Widget _listComments(List<CommentDatum> comments, CommentViewModel vm) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final item = comments[index];
        return InkWell(
          onLongPress: () => _modal(context, vm, item),
          child: Padding(
            padding: AppStyles.paddingBody,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          item.user.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const Text(' · '),
                        Text(timeago.format(item.createdAt)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(item.comment),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  void _modal(BuildContext context, CommentViewModel vm, CommentDatum comment) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () => vm.deleteComment(comment.id),
              leading: const Icon(Icons.delete_rounded),
              title: const Text('Delete'),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                vm.isEditing = true;
                vm.editingSelect = comment.id;
                vm.controller.text = comment.comment;
              },
              leading: const Icon(Icons.edit_rounded),
              title: const Text('Edit'),
            ),
          ],
        );
      },
    );
  }
}
