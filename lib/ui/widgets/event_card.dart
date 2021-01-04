import 'package:flutter/material.dart';
import 'package:state_management_test/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Function onTap;

  const EventCard({Key key, this.event, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: InkWell(
        highlightColor: Colors.amberAccent,
        onTap: onTap,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(event.title.toUpperCase()),
                    Text(event.user.name),
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
        ),
      ),
    );
  }
}
