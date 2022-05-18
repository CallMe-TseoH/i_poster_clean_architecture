import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_poster/config/routes/routes.dart' show RMI;
import 'package:i_poster/config/theme/app_colors.dart';
import 'package:i_poster/core/enums/enums.dart';
import 'package:i_poster/core/helpers/helpers.dart' show AppFontSizesHelper, SizesHelper;
import 'package:i_poster/features/home/domain/entities/entities.dart' show PostEntity;
import 'package:i_poster/features/home/home.dart';
import 'package:i_poster/features/home/presentation/cubit/home_cubit.dart';
import 'package:i_poster/features/home/presentation/widgets/post_tile_button.dart';
import 'package:i_poster/features/widgets/widgets.dart' show AppSpin, ExtendedContainer, TextComponent;

class PostTileFooter extends StatelessWidget {
  const PostTileFooter({
    super.key,
    required this.postEntity, this.onDetailPage = false,
  });

  final PostEntity postEntity;
  final bool onDetailPage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizesHelper.height(70),
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => _rebuildWhenForDeletion(previous, current) || previous.selectedPosts != current.selectedPosts,
        builder: (context, state) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.selectedPosts.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Checkbox(
                      value: state.selectedPosts.contains(postEntity),
                      onChanged: (_) {
                        context.read<HomeCubit>().addPostInSelection(id: postEntity.id);
                      }),
                )
              ] else ...[
                PostTileButton(
                  icon: Icons.edit,
                  title: 'Editer',
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      RMI.editing,
                      arguments: postEntity,
                    ).then((value){
                      if(value != null){
                        context.read<HomeCubit>().updatePostsList(value as PostEntity);
                        if(onDetailPage){
                          return Navigator.of(context).pop();
                        }
                      }
                    });
                  },
                ),
                ExtendedContainer(
                  size: SizesHelper.height(35),
                  color: AppColors.dark.withOpacity(.35),
                  shape: BoxShape.circle,
                  child: Center(child: TextComponent(textKey: postEntity.id.toString(), textAlign: TextAlign.center, fontSize: AppFontSizesHelper.s-2,)),
                ),
                if (state.deletionStatus == EventStatusEnum.loading) ...[const Expanded(child: AppSpin())] else
                  PostTileButton(
                    icon: Icons.delete,
                    title: 'Supprimer',
                    onPressed: () {
                      context.read<HomeCubit>().deletePost(id: postEntity.id);
                    },
                  )
              ]
            ],
          );
        },
      ),
    );
  }

  bool _rebuildWhenForDeletion(HomeState previous, HomeState current) =>
      previous.deletionStatus != current.deletionStatus && current.lastDeletedPost! == postEntity;
}
