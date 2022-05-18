import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_poster/config/routes/routes.dart' show RMI;
import 'package:i_poster/core/helpers/helpers.dart';
import 'package:i_poster/features/home/domain/entities/entities.dart' show PostEntity;
import 'package:i_poster/features/home/home.dart';
import 'package:i_poster/features/home/presentation/cubit/home_cubit.dart';
import 'package:i_poster/features/home/presentation/widgets/post_tile_button.dart';
import 'package:i_poster/features/home/presentation/widgets/post_tile_footer.dart';
import 'package:i_poster/features/widgets/widgets.dart' show ExtendedContainer, MaterialInkWell, TextComponent;

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required PostEntity post,
  }) : _post = post;

  final PostEntity _post;

  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      elevation: .85,
      child: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) => previous.selectedPosts != current.selectedPosts,
          builder: (context, state) {
    return MaterialInkWell(
        onPressed: () {
          if(state.selectedPosts.isEmpty) {
            Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
              builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<HomeCubit>(context),
                    child: PostDetailPage(postEntity: _post),
                  )));
          }else{
            context.read<HomeCubit>().addPostInSelection(id: _post.id);
          }
        },
        onLongPressed: (){
          context.read<HomeCubit>().addPostInSelection(id: _post.id);
        },
        child: Padding(
          padding: EdgeInsets.only(top: SizesHelper.height(5)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: TextComponent(
                  textKey: _post.title.toUpperCase(),
                  textAlign: TextAlign.left,
                ),
                subtitle: TextComponent(
                  textKey: _post.body,
                  textAlign: TextAlign.left,
                  fontSize: AppFontSizesHelper.sm,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Divider(),
              ),
               PostTileFooter(postEntity: _post,)
            ],
          ),
        ),
      );
  },
),
    );
  }
}
