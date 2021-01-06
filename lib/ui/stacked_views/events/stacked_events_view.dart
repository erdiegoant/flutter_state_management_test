import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:state_management_test/ui/stacked_views/events/events_viewmodel.dart';
import 'package:state_management_test/ui/widgets/event_card.dart';

class StackedEventsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stacked Events'),
      ),
      body: _PageBody(),
      floatingActionButton: _CreateEventButton(),
    );
  }
}

class _PageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventsViewModel>.nonReactive(
      viewModelBuilder: () => EventsViewModel(),
      fireOnModelReadyOnce: true,
      onModelReady: (model) => model.futureToRun,
      builder: (_, model, child) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 30),
            Center(
              child: Text(
                'Events page',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
            _EventsList(),
          ],
        );
      },
    );
  }
}

class _EventsList extends ViewModelWidget<EventsViewModel> {
  @override
  bool get reactive => true;

  @override
  Widget build(BuildContext context, EventsViewModel model) {
    return model.isBusy
        ? RefreshProgressIndicator()
        : Expanded(
            child: RefreshIndicator(
              onRefresh: model.fetchEvents,
              displacement: 10,
              child: ListView.builder(
                itemCount: model.events.length,
                itemBuilder: (_, index) {
                  return EventCard(
                    event: model.events[index],
                    onTap: () {
                      model.navigateToEventDetail(
                        eventId: model.events[index].id,
                        title: model.events[index].title,
                      );
                    },
                  );
                },
              ),
            ),
          );
  }
}

class _CreateEventButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventsViewModel>.nonReactive(
      viewModelBuilder: () => EventsViewModel(),
      builder: (_, model, child) {
        return FloatingActionButton(
          onPressed: model.navigateToCreateEvent,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
