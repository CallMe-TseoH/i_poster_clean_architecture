import 'package:flutter/material.dart';
import 'package:i_poster/config/theme/theme.dart' show AppColors;
import 'package:i_poster/core/helpers/helpers.dart' show AppFontSizesHelper;
import 'package:i_poster/features/home/domain/entities/entities.dart' show PostEntity;
import 'package:i_poster/features/home/presentation/widgets/widgets.dart' show PostTileFooter;
import 'package:i_poster/features/widgets/widgets.dart' show TextComponent;

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key, required this.postEntity});

  final PostEntity postEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  TextComponent(
                    textKey: postEntity.title,
                    fontSize: AppFontSizesHelper.xl,
                    useOverFlow: false,
                    textAlign: TextAlign.left,
                  ),
                  Divider(),
                  TextComponent(
                    textKey: postEntity.body,
                    fontSize: AppFontSizesHelper.ml,
                    useOverFlow: false,
                    color: AppColors.dark.withOpacity(.75),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
           PostTileFooter(postEntity: postEntity, onDetailPage: true,)
        ],
      ),
    );
  }
}
