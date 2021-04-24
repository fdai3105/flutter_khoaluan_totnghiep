import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/presentation/presentation.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../resources/models/comment.dart';
import '../../../configs/configs.dart';
import '../../../resources/repositories/product.dart';
import '../../base/base.dart';
import 'comment.dart';

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
            productResponse: ProductResponse(),
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
      padding: AppStyles.paddingBody,
      child: _listComments(vm.comments.data),
    );
  }

  Widget _field(CommentViewModel vm) {
    var comment ='';
    return Row(
      children: [
        Expanded(
          child: WidgetTextField(
            onChanged: (value) => {comment = value},
            hint: 'Write a comment',
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send,color: AppColors.primary),
          onPressed: () => vm.addComment(productId, comment),
        ),
      ],
    );
  }

  Widget _listComments(List<CommentDatum> comments) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final item = comments[index];
        return GestureDetector(
          onLongPress: () {

          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
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
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
