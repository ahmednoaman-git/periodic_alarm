import 'package:flutter/material.dart';
import 'package:periodic_alarm/model/alarms_model.dart';
import 'dart:async';

import 'package:periodic_alarm/periodic_alarm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _subscription;
  bool alarm = false;
  @override
  void initState() {
    super.initState();
    onRingingControl();
    PeriodicAlarm.init();
  }

  onRingingControl() {
    _subscription = PeriodicAlarm.ringStream.stream.listen(
      (alarmSettings) => debugPrint('object'),
    );

    setState(() {});
  }

  Future<void> setAlarm() async {
    AlarmModel alarmModel = AlarmModel(
      id: 0,
      dateTime: DateTime.now().add(Duration(seconds: 5)),
      assetAudioPath: 'assets/0.mp3',
      notificationTitle: 'Alarm is calling',
      notificationBody: 'Tap to turn off the alarm',
      active: true,
    );

    PeriodicAlarm.setOneAlarm(alarmModel: alarmModel);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Switch(
            value: alarm,
            onChanged: (value) {
              alarm = value;
              setState(() {});
              if (value) {
                setAlarm();
              }
            },
          ),
        ),
      ),
    );
  }
}
