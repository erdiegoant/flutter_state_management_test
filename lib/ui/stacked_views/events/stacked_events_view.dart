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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ViewModelBuilder<EventsViewModel>.nonReactive(
        viewModelBuilder: () => EventsViewModel(),
        fireOnModelReadyOnce: true,
        onModelReady: (model) => model.futureToRun,
        builder: (_, model, child) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Text(
                  'Events page',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 30),
              _EventsList(),
            ],
          );
        },
      ),
    );
  }
}

class _EventsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventsViewModel>.reactive(
      viewModelBuilder: () => EventsViewModel(),
      builder: (_, model, child) {
        if (model.isBusy) {
          return CircularProgressIndicator();
        }

        print(model.events);

        return model.events.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  itemCount: model.events.length,
                  itemBuilder: (_, index) {
                    return EventCard(event: model.events[index]);
                  },
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [
                    Center(
                      child: Text('No events'),
                    ),
                    RaisedButton(
                      onPressed: model.fetchEvents,
                      child: Text('Reload'),
                    ),
                  ],
                ),
              );
      },
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
