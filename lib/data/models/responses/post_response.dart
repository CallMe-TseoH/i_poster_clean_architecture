import 'package:equatable/equatable.dart';

class PostResponse extends Equatable {
  PostResponse({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  @override
  List<Object> get props => [id, userId, title, body];


  @override
  String toString() {
    return 'PostResponse{id: $id, userId: $userId, title: $title}';
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  late final int id;
  final int userId;
  final String title;
  final String body;
//

}
