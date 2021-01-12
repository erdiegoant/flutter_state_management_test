import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:state_management_test/app/locator.dart';
import 'package:state_management_test/models/event.dart';
import 'package:state_management_test/ui/stacked_views/events/events_viewmodel.dart';
import 'package:state_management_test/ui/widgets/event_card.dart';

class StackedEventsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => locator<EventsViewModel>(),
      fireOnModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      onModelReady: (model) => model.futureToRun,
      builder: (_, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Stacked Events'),
        ),
        body: _PageBody(),
        floatingActionButton: _CreateEventButton(),
      ),
    );
  }
}

class _PageBody extends ViewModelWidget<EventsViewModel> {
  @override
  bool get reactive => true;

  @override
  Widget build(BuildContext context, model) {
    return RefreshIndicator(
      onRefresh: model.fetchEvents,
      displacement: 10,
      child: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 30),
              Center(
                child: Text(
                  'Events page',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          _EventsList(
            events: model.events,
            onTap: model.navigateToEventDetail,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _EventsList extends StatelessWidget {
  final List<Event> events;
  final Function onTap;

  const _EventsList({
    Key key,
    this.events = const [],
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: events
          .map(
            (event) => EventCard(
              event: event,
              onTap: () {
                onTap(
                  eventId: event.id,
                  title: event.title,
                );
              },
            ),
          )
          .toList(),
    );
  }
}

class _CreateEventButton extends ViewModelWidget<EventsViewModel> {
  @override
  bool get reactive => false;

  @override
  Widget build(BuildContext context, model) {
    return FloatingActionButton(
      onPressed: model.navigateToCreateEvent,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
