class Event {
  final int id;
  final int user_id;
  final String title;
  final String description;
  List<EventComment> comments = [];

  Event({this.id, this.user_id, this.title, this.description, this.comments});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      user_id: json['user_id'],
      title: json['title'],
      description: json['description'],
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

  EventComment({this.id, this.event_id, this.user_id, this.comment});

  factory EventComment.fromJson(Map<String, dynamic> json) {
    return EventComment(
      id: json['id'],
      event_id: json['event_id'],
      user_id: json['user_id'],
      comment: json['comment'],
    );
  }
}
