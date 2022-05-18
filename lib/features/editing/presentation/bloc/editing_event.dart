part of 'editing_bloc.dart';

abstract class EditingEvent extends Equatable {
  const EditingEvent();

  @override
  List<Object?> get props => [];
}

class EditingOnTitleChanged extends EditingEvent {
  const EditingOnTitleChanged({required this.title});

  final String title;

  @override
  List<Object?> get props => [title];
}

class EditingOnContentChanged extends EditingEvent {
  const EditingOnContentChanged({required this.content});

  final String content;

  @override
  List<Object?> get props => [content];
}

class EditingOnFormSubmitted extends EditingEvent {
  const EditingOnFormSubmitted({this.postToUpdated});

  final PostEntity? postToUpdated;

  @override
  List<Object?> get props => [postToUpdated];
}
