import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_poster/features/editing/data/data.dart';
import 'package:i_poster/features/editing/presentation/bloc/editing_bloc.dart';
import 'package:i_poster/features/editing/presentation/pages/editing_page.dart';
import 'package:i_poster/features/home/data/data.dart';
import 'package:i_poster/features/home/domain/entities/entities.dart' show PostEntity;

class Editing extends StatelessWidget {
  const Editing({super.key, this.postEntity});

  static const routeName = '/Editing';
  final PostEntity? postEntity;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EditingPostRepositoryImpl(
        localDataSource: LocalDataSource(),
        editingPostApiDataSource: EditingPostApiDataSourceImpl(Dio()),
      ),
      child: BlocProvider(
        create: (context) => EditingBloc(RepositoryProvider.of<EditingPostRepositoryImpl>(context))
          ..add(EditingOnTitleChanged(title: postEntity?.title ?? ''))
          ..add(EditingOnContentChanged(content: postEntity?.body ?? '')),
        child: EditingPage(
          postEntity: postEntity,
        ),
      ),
    );
  }
}
