import 'package:equatable/equatable.dart';
import 'package:i_poster/core/interfaces/interfaces.dart';
import 'package:i_poster/features/home/domain/domain.dart';
import 'package:i_poster/features/home/domain/entities/entities.dart' show PostEntity;

class GetPostsList extends UseCase<List<PostEntity>, NoParams> {
  factory GetPostsList({required PostRepository postRepository}) {
    _instance.postRepository = postRepository;
    return _instance;
  }

  GetPostsList._();

  static final GetPostsList _instance = GetPostsList._();

  late PostRepository postRepository;

  @override
  Future<List<PostEntity>> execute(NoParams parameters) {
    return postRepository.getPosts();
  }
}

class NoParams extends Equatable{
  @override
  List<Object?> get props => [];

}
