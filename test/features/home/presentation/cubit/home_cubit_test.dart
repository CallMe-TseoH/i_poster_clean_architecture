import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i_poster/bootstrap.dart';
import 'package:i_poster/core/enums/enums.dart';
import 'package:i_poster/features/home/data/repositories/post_repository_impl.dart';
import 'package:i_poster/features/home/domain/domain.dart';
import 'package:i_poster/features/home/domain/entities/entities.dart' show PostEntity;
import 'package:i_poster/features/home/presentation/cubit/home_cubit.dart' show HomeCubit, HomeState;
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/hydrated_bloc_helper.dart';

class MockPostRepository extends Mock implements PostRepository {}

class FakePost extends Fake implements PostEntity {}

void main() {
  const deletedPost = PostEntity(
    id: 4,
    title: 'title 4',
    body: 'body 6',
  );
  final mockPosts = [
    const PostEntity(
      id: 1,
      title: 'title 1',
      body: 'body 1',
    ),
    const PostEntity(
      id: 2,
      title: 'title 2',
      body: 'body 2',
    ),
    const PostEntity(
      id: 3,
      title: 'title 3',
      body: 'body 3',
    ),
    deletedPost,
  ];

  group('HomeCubit', () {
    late PostRepository postRepository;
    late HomeCubit buildCubit;
    setUpAll(() {
      registerFallbackValue(FakePost());
    });

    setUp(() async {
      postRepository = MockPostRepository();
      when(() => postRepository.getPosts()).thenAnswer((invocation) => Future<List<PostEntity>>.value(mockPosts));
      buildCubit = await mockHydratedStorage(() {
        return HomeCubit(postRepository: postRepository);
      });
    });

    group('Test Constructor', () {
      test('Work as good', () {
        mockHydratedStorage(() {
          expect(() => buildCubit, returnsNormally);
        });
      });

      test('Initial State', () {
        mockHydratedStorage(() {
          expect(buildCubit.state, equals(const HomeState()));
        });
      });
    });

    group('getPosts', () {
      blocTest<HomeCubit, HomeState>('verify getPostList calledProper',
          build: () => buildCubit,
          act: (cubit) => cubit.getPosts(),
          verify: (_) {
            verify(() => postRepository.getPosts()).called(1);
          });
      blocTest<HomeCubit, HomeState>('get Post List',
          build: () => buildCubit,
          act: (cubit) => cubit.getPosts(),
          expect: () => [
                const HomeState(
                  status: EventStatusEnum.loading,
                ),
                HomeState(
                  status: EventStatusEnum.success,
                  posts: mockPosts,
                )
              ]);
    });

    group('delete post', () {
      blocTest<HomeCubit, HomeState>('verify deletePost calledProper',
          setUp: () {
            when(() => postRepository.deletePost(id: any<int>(named: 'id')))
                .thenAnswer((invocation) => Future<int>.value(mockPosts.last.id));
          },
          build: () => buildCubit,
          seed: () => HomeState(posts: mockPosts),
          act: (cubit) => cubit.deletePost(id: mockPosts.last.id),
          expect: () => [
                HomeState(
                  posts: mockPosts,
                  deletionStatus: EventStatusEnum.loading,
                  lastDeletedPost: deletedPost,
                ),
                HomeState(
                  deletionStatus: EventStatusEnum.success,
                  posts: mockPosts..remove(deletedPost),
                  lastDeletedPost: deletedPost,
                ),
              ],
          verify: (_) {
            verify(() => postRepository
                .deletePost(id: deletedPost.id),)
                .called(1);
          });
    });
  });
}
