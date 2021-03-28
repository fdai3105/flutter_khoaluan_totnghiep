import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      appBar: _appBar(context),
      body: SafeArea(
        child: BaseWidget<CommentViewModel>(
          viewModel: CommentViewModel(
            productResponse: ProductResponse(),
          ),
          onViewModelReady: (vm) async {
            await vm.init(productId);
          },
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              padding: AppStyles.paddingBody,
              child: WidgetCommentList(comments: vm.comments.data),
            );
          },
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Comments',
        style: TextStyle(color: AppColors.textDark),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.close_outlined, color: AppColors.textDark),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add_comment_outlined, color: AppColors.textDark),
          onPressed: () {

          },
        )
      ],
    );
  }
}

class WidgetCommentList extends StatelessWidget {
  final List<CommentDatum> comments;

  const WidgetCommentList({
    Key key,
    @required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final item = comments[index];
        return Column(
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
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
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
        );
      },
    );
  }
}
