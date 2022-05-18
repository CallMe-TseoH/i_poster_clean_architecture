import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_poster/core/enums/enums.dart';
import 'package:i_poster/data/data.dart' show PostRequest;
import 'package:i_poster/features/editing/domain/domain.dart';
import 'package:i_poster/features/home/domain/entities/entities.dart';

part 'editing_event.dart';

part 'editing_state.dart';

class EditingBloc extends Bloc<EditingEvent, EditingState> {
  EditingBloc(this._editingPostRepository) : super(const EditingState()) {
    on<EditingOnTitleChanged>(_onEditingOnTitleChanged);
    on<EditingOnContentChanged>(_onEditingOnContentChanged);
    on<EditingOnFormSubmitted>(_onEditingOnFormSubmitted);
  }

  final EditingPostRepository _editingPostRepository;

  void _onEditingOnTitleChanged(
    EditingOnTitleChanged event,
    Emitter<EditingState> emit,
  ) {
    emit(
      state.copyWith(
        formStatus: state.getFormStatus(
          title: event.title,
          content: state.content,
        ),
        title: event.title.trim(),
      ),
    );
  }

  void _onEditingOnContentChanged(
    EditingOnContentChanged event,
    Emitter<EditingState> emit,
  ) {
    emit(
      state.copyWith(
        formStatus: state.getFormStatus(
          content: event.content,
          title: state.content,
        ),
        content: event.content.trim(),
      ),
    );
  }

  Future<void> _onEditingOnFormSubmitted(
    EditingOnFormSubmitted event,
    Emitter<EditingState> emit,
  ) async {
    emit(state.copyWith(status: EventStatusEnum.loading));
    if (state.formStatus == FormStatus.validated) {
      try {
        PostEntity? _post;
        if (event.postToUpdated != null) {
          _post = await _editingPostRepository.updatePost(
            postRequest: PostRequest(
              id: event.postToUpdated?.id,
              title: state.title,
              body: state.content,
            ),
          );
        } else {
          _post = await _editingPostRepository.createPost(
            postRequest: PostRequest(
              id: state.postToUpdated?.id,
              title: state.title,
              body: state.content,
            ),
          );
        }
        emit(
          state.copyWith(
            status: EventStatusEnum.success,
            lastUpdatedOrCreated: _post,
          ),
        );
      } catch (e, stack) {
        emit(state.copyWith(status: EventStatusEnum.failure));
      }
      return;
    }
    emit(state.copyWith(status: EventStatusEnum.failure));
  }
}
