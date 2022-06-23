
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {

  final BuildContext context;
  final DateTime dateTime;

  ClockPainter(this.context, this.dateTime);//construtor

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2; //altura da tela / 2
    double centerY = size.height / 2; //largura da tela /2
    Offset center = Offset(centerX, centerY); //posiçao do centro

    //calculo minutos
    double minX = centerX + size.width * 0.35 * cos((dateTime.minute * 6) * pi/180);
    double minY = centerX + size.width * 0.35 * sin((dateTime.minute * 6) * pi/180);

    //ponteiro minutos
    canvas.drawLine(
      center,
      Offset(minX, minY),
      Paint()
        ..color = Theme.of(context).accentColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10,
    );

    //calculo horas
    double hourX = centerX + size.width * 0.3 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi/180);
    double hourY = centerY + size.width * 0.3 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi/180);

    //ponteiro horas
    canvas.drawLine(
      center,
      Offset(hourX, hourY),
      Paint()
        ..color = Theme.of(context).colorScheme.secondary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10,
    );

    //calculo segundos
    double secondX = centerX + size.width * 0.4 * cos((dateTime.second * 6) * pi / 180);
    double secondY = centerY + size.width * 0.4 * sin((dateTime.second * 6) * pi / 180);

    //ponteiro segundos
    canvas.drawLine(
      center,
      Offset(secondX, secondY),
      Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );


    //bolinha do centro dos ponteiros
    Paint doPainter = Paint()
      ..color = Theme.of(context).primaryIconTheme.color!;
    canvas.drawCircle(
      center,
      24,
      doPainter,
    ); //bolinha exterior, cinza
    canvas.drawCircle(
      center,
      23,
      Paint()..color = Theme.of(context).backgroundColor,
    ); //bolinha do meio, branco

    canvas.drawCircle(
      center,
      10,
      doPainter,
    ); //bolinha do centro, cinza
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}