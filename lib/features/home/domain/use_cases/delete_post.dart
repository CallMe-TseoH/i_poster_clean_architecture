import 'package:i_poster/core/interfaces/interfaces.dart';
import 'package:i_poster/features/home/domain/repositories/post_repository.dart';

class DeletePost extends UseCase<int, int>{

  factory DeletePost({required PostRepository postRepository}){
    _instance.postRepository = postRepository;
    return _instance;
  }

  DeletePost._();
  static  final DeletePost _instance = DeletePost._();

  late PostRepository postRepository;
  @override
  Future<int> execute(int parameters) {
    return postRepository.deletePost(id: parameters);
  }
  

}
