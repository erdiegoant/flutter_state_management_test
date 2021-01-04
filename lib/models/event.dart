import 'package:state_management_test/models/user.dart';

class Event {
  final int id;
  final int user_id;
  final String title;
  final String description;
  final User user;
  List<EventComment> comments = [];

  Event({
    this.id,
    this.user_id,
    this.title,
    this.description,
    this.comments,
    this.user,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      user_id: json['user_id'],
      title: json['title'],
      description: json['description'],
      user: User.fromJson(json['user']),
      comments: (json['comments'] as List)
          ?.map((comment) => EventComment.fromJson(comment))
          ?.toList(),
    );
  }
}

class EventComment {
  final int id;
  final String comment;
  final int event_id;
  final int user_id;
  final User user;

  EventComment({this.id, this.event_id, this.user_id, this.comment, this.user});

  factory EventComment.fromJson(Map<String, dynamic> json) {
    return EventComment(
      id: json['id'],
      event_id: json['event_id'],
      user_id: json['user_id'],
      user: User.fromJson(json['user']),
      comment: json['comment'],
    );
  }
}
