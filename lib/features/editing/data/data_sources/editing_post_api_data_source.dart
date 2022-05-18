import 'package:dio/dio.dart';
import 'package:i_poster/data/data.dart' show JsonMap, PostRequest, PostResponse;

abstract class EditingPostApiDataSource{
  //
  Future<PostResponse?> updatePost({required PostRequest postRequest});

  //
  Future<PostResponse?> createPost({required PostRequest postRequest});

}

class EditingPostApiDataSourceImpl extends EditingPostApiDataSource{
  EditingPostApiDataSourceImpl(this._dio);
  static const _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  final Dio _dio;
  @override
  Future<PostResponse?> createPost({required PostRequest postRequest}) async {
    final _response = await _dio.post<JsonMap>(_baseUrl, data: postRequest.forCreateNewPost());
    if([200, 201].contains(_response.statusCode )){
      return PostResponse.fromJson(_response.data!);
    }
    return null;
  }

  @override
  Future<PostResponse?> updatePost({required PostRequest postRequest}) async {
    final _response = await _dio.patch<JsonMap>(
      '$_baseUrl/${postRequest.id}',
      data: postRequest.toJson(),
    );
    if (_response.statusCode == 200) {
      final _data =_response.data!;
      final _updatedPost = PostResponse(
        userId: 1,
        id: postRequest.id!,
        title: (_data['title'] as String?)??(postRequest.title)??'-',
        body: (_data['body']  as String?)??postRequest.body??'-',
      );
      print(_updatedPost);
      return _updatedPost;
    }
    return null;
  }
}