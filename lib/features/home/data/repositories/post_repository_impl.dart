import 'package:i_poster/features/home/data/data.dart';
import 'package:i_poster/features/home/domain/domain.dart';
import 'package:i_poster/features/home/domain/entities/post_entity.dart';

class PostRepositoryImpl extends PostRepository {
  PostRepositoryImpl({
    required this.apiDataSource,
    required this.localDataSource,
  });

  final ApiDataSource apiDataSource;
  final LocalDataSource localDataSource;

  @override
  Future<int> deletePost({required int id}) {
    return apiDataSource.deletePost(id: id);
  }

  @override
  Future<List<PostEntity>> getPosts() {
    return apiDataSource.getPosts().then((elements) {
      if (elements.isNotEmpty) {
      return elements.map(
          (element) => PostEntity(
            id: element.id,
            title: element.title,
            body: element.body,
          ),
        ).toList();
      }
      return [];
    });
  }
}
