import 'package:analog_clock/screens/components/country_card.dart';
import 'package:analog_clock/screens/components/time_in_hour_and_minute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'clock.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "Santa Helena | PR",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TimeInHourAndMinuteState(),
            Clock(),
            Spacer(),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),//fisica ao chegar ao limite da tela
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CountryCard(
                    country: "New York | USA",
                    iconSRC: "assets/icons/Liberty.svg",
                    timeZone: "+3 HRS | EST",
                    time: "15:00",
                    period: "PM",
                  ),
                  CountryCard(
                    country: "Sydney | AU",
                    iconSRC: "assets/icons/Sydney.svg",
                    timeZone: "+19 HRS | AEST",
                    time: "10:00",
                    period: "AM",
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
