part of 'editing_bloc.dart';


enum FormStatus { validated, invalidated }

extension EditingFormState on EditingState{
  FormStatus getFormStatus({required String title, required String content}) {
    if (title.isNotEmpty && content.isNotEmpty) {
      return FormStatus.validated;
    }
    return FormStatus.invalidated;
  }
}

class EditingState extends Equatable {
  const EditingState({
    this.status = EventStatusEnum.initial,
    this.title = '',
    this.content = '',
    this.formStatus = FormStatus.invalidated,
    this.postToUpdated,
    this.lastUpdatedOrCreated,
  });

  final EventStatusEnum status;
  final FormStatus formStatus;
  final String title;
  final String content;
  final PostEntity? postToUpdated;
  final PostEntity? lastUpdatedOrCreated;

  @override
  List<Object?> get props => [status, formStatus, title, content, postToUpdated, lastUpdatedOrCreated,];

  EditingState copyWith({
    EventStatusEnum? status,
    FormStatus? formStatus,
    String? title,
    String? content,
    PostEntity? postToUpdated,
    PostEntity? lastUpdatedOrCreated,
  }) {
    return EditingState(
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      title: title ?? this.title,
      content: content ?? this.content,
      postToUpdated: postToUpdated ?? this.postToUpdated,
      lastUpdatedOrCreated: lastUpdatedOrCreated ?? this.lastUpdatedOrCreated,
    );
  }
}
