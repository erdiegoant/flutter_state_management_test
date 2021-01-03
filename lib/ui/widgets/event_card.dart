import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:state_management_test/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(event.title.toUpperCase()),
                Text(event.user_id.toString()),
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(event.description),
            ),
          ],
        ),
      ),
    );
  }
}
