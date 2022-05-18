import 'package:flutter/cupertino.dart' show CupertinoScrollbar;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_poster/config/routes/routes.dart' show RMI;
import 'package:i_poster/config/theme/theme.dart' show AppColors;
import 'package:i_poster/core/enums/event_status_enum.dart';
import 'package:i_poster/core/helpers/helpers.dart';
import 'package:i_poster/features/home/domain/entities/entities.dart';
import 'package:i_poster/features/home/presentation/cubit/home_cubit.dart';
import 'package:i_poster/features/home/presentation/widgets/widgets.dart' show PostTile;
import 'package:i_poster/features/widgets/text_component.dart';
import 'package:i_poster/features/widgets/widgets.dart' show AppSpin, EmptyViewerComponent, ErrorViewerComponent, ExtendedContainer, Separator;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: AppColors.white,
        statusBarColor: AppColors.white,
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  context.read<HomeCubit>().getPosts();
                },
                icon: Icon(
                  Icons.refresh,
                  color: AppColors.dark,
                ))
          ],
        ),
        body: Column(
          children: [
            ExtendedContainer(
              height: SizesHelper.height(150),
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Separator(value: 20),
                  TextComponent(
                    textKey: 'IPoster !'.toUpperCase(),
                    fontSize: AppFontSizesHelper.xxl,
                  ),
                  TextComponent(
                    textKey: 'Hello, welcome back.',
                    fontSize: AppFontSizesHelper.sm,
                    color: AppColors.dark.withOpacity(.35),
                  ),
                ],
              )),
            ),
            const Divider(),
            Expanded(
              child: BlocConsumer<HomeCubit, HomeState>(
                listenWhen: (previous, current) => previous.deletionStatus != current.deletionStatus,
                listener: (context, state) {
                  if (state.deletionStatus == EventStatusEnum.failure) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(const SnackBar(content: Text('Something went wrong')));
                  }
                },
                buildWhen: _rebuildWhenForListView,
                builder: (context, state) {
                  switch (state.status) {
                    case EventStatusEnum.success:
                      return CupertinoScrollbar(
                        child: ListView.builder(
                            itemCount: state.posts.length,
                            itemBuilder: (BuildContext _, int index) {
                              final _post = state.posts.reversed.toList()[index];
                              return PostTile(post: _post);
                            }),
                      );
                    case EventStatusEnum.failure:
                      if (state.posts.isEmpty) {
                        return EmptyViewerComponent(
                          onTryAgainPressed: () {
                            context.read<HomeCubit>().getPosts();
                          },
                        );
                      }
                      return ErrorViewerComponent(
                        onTryAgainPressed: () {
                          context.read<HomeCubit>().getPosts();
                        },
                      );
                    default:
                      return const AppSpin();
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: BlocConsumer<HomeCubit, HomeState>(
          listenWhen: (previous, current) => previous.onDeletePostsGroup != current.onDeletePostsGroup,
          listener: (context, state) {
            if (state.onDeletePostsGroup) {
              showDialog<dynamic>(
                useSafeArea: false,
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  return const AppSpin();
                },
              );
            } else {
              if (ModalRoute.of(context)?.isCurrent != true) {
                Navigator.of(context).pop();
              }
            }
          },
          buildWhen: (previous, current) => previous.selectedPosts != current.selectedPosts,
          builder: (context, state) {
            return FloatingActionButton(
              backgroundColor: AppColors.dark,
              onPressed: () {
                if (state.selectedPosts.isNotEmpty) {
                  context.read<HomeCubit>().deletePostByGroup();

                  return;
                }
                Navigator.of(context).pushNamed(RMI.editing).then((value) {
                  if (value != null) {
                    context.read<HomeCubit>().updatePostsList(value as PostEntity);
                  }
                });
              },
              child: Icon(
                state.selectedPosts.isNotEmpty ? Icons.delete : Icons.add,
                color: AppColors.white,
              ),
            );
          },
        ),
      ),
    );
  }

  bool _rebuildWhenForListView(HomeState previous, HomeState current) =>
      previous.status != current.status || previous.deletionStatus != current.deletionStatus || previous.posts != current.posts;
}
