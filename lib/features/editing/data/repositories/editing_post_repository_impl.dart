import 'package:i_poster/data/data.dart' show JsonMap, LocalDataSource, PostRequest, PostResponse;
import 'package:i_poster/features/editing/data/data.dart';
import 'package:i_poster/features/editing/domain/repositories/editing_post_repository.dart';
import 'package:i_poster/features/home/domain/entities/entities.dart';

class EditingPostRepositoryImpl extends EditingPostRepository {
  EditingPostRepositoryImpl({
    required this.localDataSource,
    required this.editingPostApiDataSource,
  });

  final LocalDataSource localDataSource;
  final EditingPostApiDataSource editingPostApiDataSource;

  @override
  Future<PostEntity?> createPost({required PostRequest postRequest}) {
    return editingPostApiDataSource.createPost(postRequest: postRequest).then((value) {
      if (value != null) {
        return PostEntity(
          id: value.id,
          title: value.title,
          body: value.body,
        );
      }
      return null;
    });
  }

  @override
  Future<PostEntity?> updatePost({required PostRequest postRequest}) {
    return editingPostApiDataSource.updatePost(postRequest: postRequest).then((value) {
      if (value != null) {
        return PostEntity(
          id: value.id,
          title: value.title,
          body: value.body,
        );
      }
      return null;
    });
  }
}
