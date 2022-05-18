import 'package:i_poster/core/interfaces/interfaces.dart';
import 'package:i_poster/data/data.dart' show PostRequest;
import 'package:i_poster/features/editing/domain/repositories/editing_post_repository.dart';
import 'package:i_poster/features/home/domain/entities/entities.dart' show PostEntity;


class UpdatePost extends UseCase<PostEntity?, PostRequest> {
  factory UpdatePost({required EditingPostRepository editingPostRepository}) {
    _instance._editingPostRepository = editingPostRepository;
    return _instance;
  }

  UpdatePost._();

  static final _instance = UpdatePost._();

  late EditingPostRepository _editingPostRepository;

  @override
  Future<PostEntity?> execute(PostRequest parameters) {
    return _editingPostRepository.updatePost(postRequest: parameters).then((value) {
      if (value != null) {
        return PostEntity(id: value.id, title: value.title, body: value.body);
      }
      return null;
    });
  }
}
