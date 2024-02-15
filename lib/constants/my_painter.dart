import 'package:flutter/material.dart';
// import 'dart:ui' as ui;

class MyPainter extends StatelessWidget {
  const MyPainter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomPaint(
        size: Size(
            200,
            (200)
                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
        painter: RPSCustomPainter(),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  // @override
  // void paint(ui.Canvas canvas, ui.Size size) {
  //   canvas.drawCircle(Offset(20, -50), 20, Paint()..color = Colors.amberAccent);
  //   canvas.drawLine(
  //       Offset(5, -50), Offset(100, -50), Paint()..strokeWidth = 20);
  //   canvas.drawArc(
  //       ui.Rect.fromCenter(center: Offset(50, 20), width: 100, height: 10),
  //       0,
  //       2.14,
  //       false,
  //       Paint()
  //         ..color = Colors.amber
  //         ..strokeWidth = 10);
  // }

  // @override
  // bool shouldRepaint(covariant CustomPainter oldDelegate) {
  //   return true;
  // }

  @override
  void paint(Canvas canvas, Size size) {
    // Circle

    Paint paintStroke = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.3112500, size.height * 0.3500000);
    path_1.cubicTo(
        size.width * 0.3362500,
        size.height * 0.3500000,
        size.width * 0.6512500,
        size.height * 0.3220000,
        size.width * 0.5337500,
        size.height * 0.3740000);
    path_1.cubicTo(
        size.width * 0.5525000,
        size.height * 0.5380000,
        size.width * 0.5712500,
        size.height * 0.5000000,
        size.width * 0.2625000,
        size.height * 0.5000000);
    path_1.cubicTo(
        size.width * 0.2375000,
        size.height * 0.5000000,
        size.width * 0.2475000,
        size.height * 0.4560000,
        size.width * 0.2475000,
        size.height * 0.3860000);
    path_1.cubicTo(
        size.width * 0.2475000,
        size.height * 0.3460000,
        size.width * 0.2675000,
        size.height * 0.3500000,
        size.width * 0.3112500,
        size.height * 0.3500000);
    path_1.close();

    canvas.drawPath(path_1, paintStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
