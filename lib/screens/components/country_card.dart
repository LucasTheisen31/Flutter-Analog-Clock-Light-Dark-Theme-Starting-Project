import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../size_config.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({
    Key? key, required this.country, required this.timeZone, required this.iconSRC, required this.time, required this.period,
  }) : super(key: key);

  final String country, timeZone, iconSRC, time, period;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15),),
      child: SizedBox(
        width: getProportionateScreenWidth(233),
        child: AspectRatio(
          //A proporção de aspecto é expressa como uma proporção de largura para altura
          aspectRatio: 1.32,
          child: Container(
            padding: EdgeInsets.all(
              getProportionateScreenWidth(20),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).primaryIconTheme.color!,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  country,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: getProportionateScreenWidth(16),
                      ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(timeZone),
                Spacer(),
                Row(
                  children: [
                    SvgPicture.asset(
                      iconSRC,
                      width: getProportionateScreenWidth(40),
                      color: Theme.of(context).accentIconTheme.color,
                    ),
                    Spacer(),
                    Text(
                      time,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(period),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
