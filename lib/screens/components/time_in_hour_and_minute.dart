
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class TimeInHourAndMinuteState extends StatefulWidget {
  const TimeInHourAndMinuteState({Key? key}) : super(key: key);

  @override
  _TimeInHourAndMinuteStateState createState() =>
      _TimeInHourAndMinuteStateState();
}

class _TimeInHourAndMinuteStateState extends State<TimeInHourAndMinuteState> {
  TimeOfDay _timeOfDay = TimeOfDay.now();


  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer){
      if(_timeOfDay.minute != TimeOfDay.now().minute){
        setState(() {
          _timeOfDay = TimeOfDay.now();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String _period = _timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${_timeOfDay.hourOfPeriod}:${_timeOfDay.minute}",//timeOfDay.hourOfPeriod FORMATO 12 HORAS
              style: Theme.of(context).textTheme.headline1),
          SizedBox(
            width: 5,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              _period,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}