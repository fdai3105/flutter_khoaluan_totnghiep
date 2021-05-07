import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../configs/configs.dart';
import '../../../resources/resources.dart';
import '../../../utils/shared_pref.dart';
import '../../presentation.dart';

class CommentDialog extends StatelessWidget {
  final int productId;

  CommentDialog({Key key, this.productId}) : super(key: key);

  final myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: WidgetAppBar(title: 'comment'.tr),
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
                Expanded(child: _body(context, vm)),
                _field(vm),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context, CommentViewModel vm) {
    if (vm.isLoading) {
      return const WidgetLoading();
    }
    if (vm.comments.data.isEmpty) {
      return const Center(child: Text('No comment yet'));
    }
    return SingleChildScrollView(
      child: _listComments(context,vm.comments.data, vm),
    );
  }

  Widget _field(CommentViewModel vm) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: WidgetInput(
              controller: vm.controller,
              node: myFocusNode,
              hint: 'write_a_comment'.tr,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              vm.isEditing ? vm.editComment() : vm.addComment(productId);
            },
            child: const Icon(Icons.send, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _listComments(BuildContext context, List<CommentDatum> comments, CommentViewModel vm) {
    final theme = Theme.of(context);
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final item = comments[index];
        return InkWell(
          onLongPress: () => item.user.id == SharedPref.getUser().user.id
              ? _modal(context, vm, item)
              : {},
          child: Padding(
            padding: AppStyles.paddingBody,
            child: Row(
              children: [
                WidgetAvatar(
                  image: item.user.avatar,
                  size: 40,
                ),
                const SizedBox(width: 10),
                Column(
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
                              style: theme.textTheme.bodyText1,
                            ),
                            const Text(' · '),
                            Text(
                              timeago.format(
                                item.createdAt,
                                locale: SharedPref.getLanguage().languageCode,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(item.comment),
                    const SizedBox(height: 10),
                  ],
                ),
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
              title: Text('delete'.tr),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                myFocusNode.requestFocus();
                vm
                  ..isEditing = true
                  ..editingSelect = comment.id
                  ..controller.text = comment.comment;
              },
              leading: const Icon(Icons.edit_rounded),
              title: Text('edit'.tr),
            ),
          ],
        );
      },
    );
  }
}
