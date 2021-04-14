import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_app/models/TimerData.dart';
import 'package:timer_app/ui/HomePage.dart';

import 'TimerPage.dart';

class TimerList extends StatefulWidget {
  @override
  _TimerListState createState() => _TimerListState();
}

class _TimerListState extends State<TimerList> {
  static final firestoreInstance = FirebaseFirestore.instance;
  List<TimerData> timers = [];
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    setState(() => _isLoading = true);
    getTimerList();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return Center(child: CircularProgressIndicator());

    return SingleChildScrollView(
      child: Column(
          children: timers
              .map((timer) => ListTile(
                    title: Text(timer.timerTitle),
                    trailing: IconButton(icon: Icon(Icons.share), onPressed: () => _shareTimer(timer)),
                    subtitle: Text('${timer.timerDuration} minutes'),
                    leading: Icon(Icons.timer),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreenPage(
                              page: 0,
                              timerValue: timer.timerDuration,
                              timerTitle: timer.timerTitle)),
                    ),
                  ))
              .toList()),
    );
  }

  void getTimerList() async {
    await firestoreInstance.collection("timer_defaults").get().then((value) {
      value.docs.forEach((result) {
        timers.add(TimerData.fromMap(result.data()));
        print(timers);
      });
      setState(() => _isLoading = false);
    });
  }

  _shareTimer(TimerData timer) {
    Share.text('${timer.timerTitle}', '${timer.timerTitle}: ${timer.timerDuration} minutes \nShared via TimerApp', 'text/plain');
  }
}
