import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:i_poster/core/enums/enums.dart';
import 'package:i_poster/data/data.dart' show JsonMap;
import 'package:i_poster/features/home/domain/domain.dart';
import 'package:i_poster/features/home/domain/entities/entities.dart';
import 'package:i_poster/features/home/domain/use_cases/use_cases.dart';

part 'home_state.dart';

class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit({required PostRepository postRepository})
      : _postRepository = postRepository,
        super(const HomeState());
  final PostRepository _postRepository;

  @override
  HomeState? fromJson(JsonMap json) => HomeState.fromJson(json);

  @override
  JsonMap? toJson(HomeState state) => state.toJson();

  Future<void> getPosts() async {
    if(state.status != EventStatusEnum.loading){
      emit(state.copyWith(status: EventStatusEnum.loading));
      try {
        await GetPostsList(postRepository: _postRepository).execute(NoParams()).then((value) {
          emit(state.copyWith(status: EventStatusEnum.success, posts: value));
        });
      } catch (e, stack) {
        emit(state.copyWith(status: EventStatusEnum.failure));
      }
    }

  }

  Future<void> deletePost({required int id}) async {
    try {
      emit(state.copyWith(deletionStatus: EventStatusEnum.loading, lastDeletedPost: state.posts.firstWhere((element) => element.id == id)));
      await DeletePost(postRepository: _postRepository).execute(id).then((response) {
        if (response > -1) {
          emit(state.copyWith(deletionStatus: EventStatusEnum.success, posts: state.posts..removeWhere((element) => element.id == id)));
        } else {
          emit(state.copyWith(deletionStatus: EventStatusEnum.failure));
        }
      });
    } catch (e, stack) {
      emit(state.copyWith(deletionStatus: EventStatusEnum.failure));
    }
  }

  Future<void> addPostInSelection({required int id}) async{
    final _newSelectionList = <PostEntity>[];
    final _selectedPost = state.posts.firstOrNullWhere((element) => element.id==id);
    if(_selectedPost != null && state.selectedPosts.contains(_selectedPost)){
      _newSelectionList..addAll(state.selectedPosts)..remove(_selectedPost);
      emit(state.copyWith(selectedPosts: _newSelectionList));
      return;
    }
     _newSelectionList..addAll(state.selectedPosts)..add(_selectedPost!);
    emit(state.copyWith(selectedPosts: _newSelectionList));
  }

  void updatePostsList(PostEntity value) {
    final _newSelectionList = <PostEntity>[...state.posts];
    final _newPost = state.posts.firstOrNullWhere((element) => element.id == value.id);
    if(_newPost != null){
      _newSelectionList.removeWhere((element) => element.id==value.id);
      emit(state.copyWith(posts: _newSelectionList));
      _newSelectionList.add(value);
      emit(state.copyWith(posts: _newSelectionList));
    }else{
      _newSelectionList.add(value);
      emit(state.copyWith(posts: _newSelectionList));
    }
  }

 Future<void> deletePostByGroup() async {
    emit(state.copyWith(onDeletePostsGroup: true));
    final _selectedPosts = [...state.selectedPosts];
   for (final _post in _selectedPosts) {
     try{
       await deletePost(id: _post.id);
       final _newSelectedPostsList = [...state.selectedPosts]..remove(_post);
       emit(state.copyWith(selectedPosts: _newSelectedPostsList));
     }catch(_){

     }
    }
    emit(state.copyWith(onDeletePostsGroup: false));
 }
}
