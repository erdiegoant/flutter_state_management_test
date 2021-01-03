import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:state_management_test/ui/stacked_views/create_event/create_event_viewmodel.dart';

class StackedEventsCreateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: _FormBody(),
        ),
      ),
    );
  }
}

class _FormBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateEventViewModel>.reactive(
      viewModelBuilder: () => CreateEventViewModel(),
      builder: (_, model, child) {
        return Column(
          children: [
            _Form(),
            SizedBox(height: 30),
            model.isBusy
                ? RaisedButton(
                    onPressed: null,
                    child: CircularProgressIndicator(),
                  )
                : RaisedButton(
                    onPressed: model.submitForm,
                    child: Text('Submit'),
                  ),
          ],
        );
      },
    );
  }
}

class _Form extends HookViewModelWidget<CreateEventViewModel> {
  @override
  Widget buildViewModelWidget(_, CreateEventViewModel model) {
    var title = useTextEditingController();
    var description = useTextEditingController();

    return Column(
      children: [
        SizedBox(height: 30),
        Text('Title'),
        TextField(
          controller: title,
          onChanged: model.setTitle,
          textAlignVertical: TextAlignVertical.center,
        ),
        SizedBox(height: 30),
        Text('Description'),
        TextField(
          controller: description,
          onChanged: model.setDescription,
          textAlignVertical: TextAlignVertical.center,
          minLines: 4,
          maxLines: 6,
        ),
      ],
    );
  }
}
