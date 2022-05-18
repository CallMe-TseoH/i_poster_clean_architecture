import 'package:i_poster/features/home/domain/entities/post_entity.dart';

abstract class PostRepository{
  Future<List<PostEntity>> getPosts();
  //
  Future<int> deletePost({required int id});
}