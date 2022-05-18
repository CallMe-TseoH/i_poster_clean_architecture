
import 'package:i_poster/data/models/json_map.dart';

class PostRequest {
  PostRequest({this.id, this.title, this.body});

  final int? id;
  final String? title;
  final String? body;

  JsonMap toJson() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      if ((title?.isNotEmpty)!) 'title': title,
      if ((body?.isNotEmpty)!) 'body': body,
    };
  }

  JsonMap forCreateNewPost(/*{required int userId}*/) {
    return <String, dynamic>{
      'userId': 1,
      'title': title,
      'body': body,
    };
  }
}
