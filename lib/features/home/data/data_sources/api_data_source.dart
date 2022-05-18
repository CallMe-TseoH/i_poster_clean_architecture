import 'package:dio/dio.dart';
import 'package:i_poster/core/constant/constant.dart' show kBaseUrl;
import 'package:i_poster/data/data.dart' show JsonMap, PostResponse;
abstract class ApiDataSource {
  Future<List<PostResponse>> getPosts();

  //
  ///Method [deletePost] will return the given [id] if
  ///post was deleted successful. It will return -1 if
  ///somethings went wrong during the deletion.
  Future<int> deletePost({required int id});
}

class ApiDataSourceImpl extends ApiDataSource {
  ApiDataSourceImpl(this._dio);

  final Dio _dio;
  static const _baseUrl = kBaseUrl;

  @override
  Future<int> deletePost({required int id})  async{
    final _response = await _dio.delete<void>('$_baseUrl/$id');
    if(_response.statusCode == 200){
      return id;
    }
    return -1;
  }

  @override
  Future<List<PostResponse>> getPosts() async {
    final _response = await _dio.get<List<dynamic>>(_baseUrl);
    if (_response.statusCode == 200) {
      if ((_response.data?.isNotEmpty)!) {
        final _postsList = List<JsonMap>.from(_response.data!).map(PostResponse.fromJson).toList();
        return _postsList;
      }
    }
    return [];
  }

}
