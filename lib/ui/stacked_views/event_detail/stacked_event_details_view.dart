import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:state_management_test/models/event.dart';
import 'package:state_management_test/ui/stacked_views/event_detail/event_details_viewmodel.dart';

class StackedEventDetailsView extends StatelessWidget {
  final int eventId;
  final String title;

  const StackedEventDetailsView(
      {Key key, @required this.eventId, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.toUpperCase()),
      ),
      body: _DetailsBody(eventId),
    );
  }
}

class _DetailsBody extends ViewModelBuilderWidget<EventDetailsViewModel> {
  final int eventId;

  _DetailsBody(this.eventId);

  @override
  bool get reactive => true;

  @override
  EventDetailsViewModel viewModelBuilder(_) => EventDetailsViewModel();

  @override
  void onViewModelReady(model) {
    model.fetchEvent(eventId);
  }

  @override
  bool get disposeViewModel => true;

  @override
  Widget builder(_, model, child) {
    return model.isBusy
        ? Center(child: CircularProgressIndicator())
        : Container(
            height: double.infinity,
            child: _EventDetails(event: model.event),
          );
  }
}

class _EventDetails extends StatelessWidget {
  final Event event;

  const _EventDetails({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                event.title.toUpperCase(),
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            event.description,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 5),
            child: Text(
              'Total comments: ${event.comments.length}',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ),
        _CommentsList(comments: event.comments ?? []),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[400],
          ),
          width: double.infinity,
          height: 1,
        ),
        _CommentInput(),
      ],
    );
  }
}

class _CommentsList extends StatelessWidget {
  final List<EventComment> comments;

  const _CommentsList({Key key, this.comments = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (_, index) {
          return _CommentItem(
            comments[index],
            isLast: index == comments.length,
          );
        },
        itemCount: comments.length,
      ),
    );
  }
}

class _CommentItem extends StatelessWidget {
  final EventComment comment;
  final bool isLast;

  const _CommentItem(this.comment, {Key key, this.isLast = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: isLast ? null : BorderSide(color: Colors.grey[300]),
        ),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.user.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 10),
          Text(
            comment.comment,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}

class _CommentInput extends HookViewModelWidget<EventDetailsViewModel> {
  @override
  Widget buildViewModelWidget(_, model) {
    var text = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 15.0,
        top: 10,
      ),
      child: TextField(
        controller: text,
        onChanged: model.setComment,
        onSubmitted: model.setComment,
        minLines: 1,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Write a comment',
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey[300],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              await model.submitComment();
              text.text = '';
            },
          ),
        ),
      ),
    );
  }
}
