import 'package:i_poster/core/interfaces/interfaces.dart';
import 'package:i_poster/data/data.dart' show PostRequest;
import 'package:i_poster/features/editing/domain/repositories/editing_post_repository.dart';
import 'package:i_poster/features/home/domain/entities/entities.dart';


class CreatePost extends UseCase<PostEntity?, PostRequest>{
  factory CreatePost({required EditingPostRepository editingPostRepository}){
    _instance._editingPostRepository = editingPostRepository;
    return _instance;
  }
  CreatePost._();
  static final _instance = CreatePost._();
  late EditingPostRepository _editingPostRepository;

  @override
  Future<PostEntity?> execute(PostRequest parameters) {
    return _editingPostRepository.createPost(postRequest: parameters)
        .then((value){
      if(value != null){
        return PostEntity(body: value.body, id: value.id, title: value.title);
      }
      return null;
    });
  }

}