part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = EventStatusEnum.initial,
    this.deletionStatus = EventStatusEnum.initial,
    this.posts = const [],
    this.selectedPosts = const [],
    this.lastDeletedPost,
    this.onDeletePostsGroup = false,
  });

  factory HomeState.fromJson(JsonMap json) {
    return HomeState(
      status: EventStatusEnum.values[json['status'] as int],
      posts: List<JsonMap>.from(json['posts'] as List<dynamic>).map(PostEntity.fromMap).toList(),
    );
  }

  final EventStatusEnum status;
  final EventStatusEnum deletionStatus;
  final List<PostEntity> posts;
  final List<PostEntity> selectedPosts;
  final PostEntity? lastDeletedPost;
  final bool onDeletePostsGroup;

  @override
  List<Object?> get props => [
        status,
        posts,
        selectedPosts,
        deletionStatus,
        lastDeletedPost,
        onDeletePostsGroup,
      ];

  JsonMap toJson() {
    return <String, dynamic>{
      'status': status.index,
      'posts': posts.map((e) => e.toMap()).toList(),
    };
  }

  HomeState copyWith({
    EventStatusEnum? status,
    EventStatusEnum? deletionStatus,
    List<PostEntity>? posts,
    List<PostEntity>? selectedPosts,
    PostEntity? lastDeletedPost,
    bool? onDeletePostsGroup,
  }) {
    return HomeState(
      status: status ?? this.status,
      deletionStatus: deletionStatus ?? this.deletionStatus,
      posts: posts ?? this.posts,
      selectedPosts: selectedPosts ?? this.selectedPosts,
      lastDeletedPost: lastDeletedPost ?? this.lastDeletedPost,
      onDeletePostsGroup: onDeletePostsGroup ?? this.onDeletePostsGroup,
    );
  }

  @override
  String toString() {
    return 'HomeState{status: $status, deletionStatus: $deletionStatus, posts: ${posts.length}, selectedPosts: ${selectedPosts.length}, lastDeletedPost: ${lastDeletedPost != null}}';
  }
}
