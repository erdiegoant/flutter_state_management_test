import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:state_management_test/ui/stacked_views/event_detail/event_details_viewmodel.dart';
import 'package:state_management_test/ui/widgets/event_card.dart';

class StackedEventDetailsView extends StatelessWidget {
  final int eventId;

  const StackedEventDetailsView({Key key, @required this.eventId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$eventId details page'),
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
        : EventCard(onTap: null, event: model.event);
  }
}
