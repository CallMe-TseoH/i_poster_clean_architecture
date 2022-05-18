import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_poster/core/enums/enums.dart';
import 'package:i_poster/core/helpers/helpers.dart';
import 'package:i_poster/features/editing/presentation/bloc/editing_bloc.dart';
import 'package:i_poster/features/home/domain/entities/entities.dart' show PostEntity;
import 'package:i_poster/features/widgets/widgets.dart' show AppElevatedButton, AppSpin, AppTextField, Separator, TextComponent;

class EditingPage extends StatelessWidget {
  const EditingPage

  ({super.key, this.postEntity});

  final PostEntity? postEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: postEntity != null ? TextComponent(textKey: (postEntity?.title)!) : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            BlocBuilder<EditingBloc, EditingState>(
              buildWhen: (previous, current) => previous.status != current.status,
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextField(
                      labelText: 'Titre',
                      value: postEntity?.title,
                      maxLine: 2,
                      hintText: 'Titre du post',
                      enabled: !_fieldState(state),
                      onChanged: (value) {
                        context.read<EditingBloc>().add(EditingOnTitleChanged(title: value));
                      },
                    ),
                    const Separator(value: 10),
                    AppTextField(
                      labelText: 'Contenu',
                      value: postEntity?.body ?? '-',
                      maxLine: 8,
                      hintText: 'Description du post',
                      enabled: !_fieldState(state),
                      onChanged: (value) {
                        context.read<EditingBloc>().add(EditingOnContentChanged(content: value));
                      },
                    ),
                  ],
                );
              },
            ),
            const Separator(value: 90),
            BlocConsumer<EditingBloc, EditingState>(
              listenWhen: (previous, current) => previous.lastUpdatedOrCreated != current.lastUpdatedOrCreated,
              listener: (context, state) {
                Navigator.of(context).pop(state.lastUpdatedOrCreated);
              },
              buildWhen: (previous, current) => previous.formStatus != current.formStatus || previous.status != current.status,
              builder: (context, state) {
                if (state.status == EventStatusEnum.loading) {
                  return SizedBox(
                    width: double.infinity,
                    height: SizesHelper.height(70),
                    child: const AppSpin(),
                  );
                }
                return AppElevatedButton(
                  title: postEntity != null ? 'Enregistrer les modifications' : 'Poster',
                  onPressed: state.formStatus== FormStatus.validated? () {
                    context.read<EditingBloc>().add(EditingOnFormSubmitted(postToUpdated: postEntity));
                  }:null,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  bool _fieldState(EditingState state) => (state.status==EventStatusEnum.loading);
}
