import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:state_management_test/app/locator.dart';
import 'package:state_management_test/app/router.gr.dart';

class HomeView extends StatelessWidget {
  final _navigationService = locator<NavigationService>();

  Future<void> _navigateToStacked() async {
    await _navigationService.navigateTo(Routes.stackedLoginView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('State management tests'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              RaisedButton(
                child: Text('Stacked package'),
                onPressed: _navigateToStacked,
              ),
              RaisedButton(child: Text('Riverpod package'), onPressed: () {}),
              RaisedButton(child: Text('GetX package'), onPressed: () {}),
              RaisedButton(child: Text('Bloc Pattern'), onPressed: () {}),
              RaisedButton(
                  child: Text('Flutter Bloc package'), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
