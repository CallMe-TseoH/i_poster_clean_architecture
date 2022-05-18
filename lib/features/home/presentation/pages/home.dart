import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_poster/features/home/data/data.dart';
import 'package:i_poster/features/home/data/repositories/post_repository_impl.dart';
import 'package:i_poster/features/home/domain/domain.dart';
import 'package:i_poster/features/home/presentation/cubit/home_cubit.dart';
import 'package:i_poster/features/home/presentation/pages/home_page.dart';

class Home extends StatelessWidget {
  const Home

  ({super.key});

  static const routeName = '/Home';

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) =>
          PostRepositoryImpl(
            apiDataSource: ApiDataSourceImpl(Dio()),
            localDataSource: LocalDataSource(),
          ),
      child: BlocProvider(
        create: (context) => HomeCubit(postRepository: RepositoryProvider.of<PostRepositoryImpl>(context))..getPosts(),
        child: const HomePage(),
      ),
    );
  }
}
