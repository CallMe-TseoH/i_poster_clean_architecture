import 'package:equatable/equatable.dart';
import 'package:i_poster/data/data.dart' show JsonMap;


class PostEntity extends Equatable {
  const PostEntity({required this.id, required this.title, required this.body});

  factory PostEntity.fromMap(JsonMap map) {
    return PostEntity(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  final int id;
  final String title;
  final String body;

  @override
  List<Object> get props => [id, title, body];

  JsonMap toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
