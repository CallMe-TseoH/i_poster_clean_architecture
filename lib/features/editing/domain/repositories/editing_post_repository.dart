import 'package:i_poster/data/data.dart' show PostRequest;
import 'package:i_poster/features/home/domain/entities/entities.dart';

abstract class EditingPostRepository{
  Future<PostEntity?> createPost({required PostRequest postRequest});

  Future<PostEntity?> updatePost({required PostRequest postRequest});
}