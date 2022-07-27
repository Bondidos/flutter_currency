import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/entities/currency_trend.dart';
import 'package:flutter_currency/presentation/controllers/trends/logic.dart';
import 'package:get/get.dart';

class TrendsPage extends StatelessWidget {
  const TrendsPage({Key? key}) : super(key: key);
  static const id = 'Trends';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Get.width,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder<TrendsLogic>(builder: (logic) {
            return CustomPaint(
              painter: TrendsPainter(trends: logic.trends),
            );
          }),
        ),
      ),
    );
  }
}

class MonthTrends extends StatelessWidget {
  const MonthTrends({
    Key? key,
    required this.trends,
  }) : super(key: key);

  final List<CurrencyTrend> trends;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TrendsPainter(trends: trends),
    );
  }
}

class TrendsPainter extends CustomPainter {
  final List<CurrencyTrend> trends;

  TrendsPainter({required this.trends});

  @override
  void paint(Canvas canvas, Size size) {
    print('width: ${size.width} heigth: ${size.height}');
    final trendPaint = Paint()
      ..strokeWidth = 2
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke;

    final trendBorder = Paint()
      ..strokeWidth = 1
      ..color = Colors.blueGrey
      ..style = PaintingStyle.stroke;

    final border = _paintGrid(size);
    canvas.drawPath(border, trendBorder);

    final trendsPath = _paintTrends(size, canvas);
    canvas.drawPath(trendsPath, trendPaint);
  }

  Path _paintGrid(Size size) {
    final path = Path();
    final border = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    path.addRect(border);
    final quarterOfPeriod = size.width / 4;
    for (var i = 1; i < 4; i++) {
      final period = quarterOfPeriod * i;
      path.moveTo(period, 0.0);
      path.relativeLineTo(0.0, size.height);

      path.moveTo(0.0, period);
      path.relativeLineTo(size.width, 0.0);
    }
      return path;
  }

  Path _paintTrends(Size size, Canvas canvas) {
    final oneDayOnCanvas = size.width / (trends.length - 1);
    var max = 0.0;
    var min = double.infinity;
    for (var element in trends) {
      if (element.rate > max) max = element.rate.ceil().toDouble();
      if (element.rate < min) min = element.rate.toInt().toDouble();
    }

    final path = Path();
    var y = 0.0;
    var x = 0.0;

    for (var element in trends) {
      final rateInGrid = size.height * (element.rate - min)/(max - min);
      if (y == 0.0 && x == 0.0) {
        y= size.height - rateInGrid;
        path.moveTo(x, y);
      } else {
        x += oneDayOnCanvas.toDouble();
        y -= rateInGrid;
        path.relativeLineTo(oneDayOnCanvas, y);
      }

      final dodeY = size.height - rateInGrid;
      final offset = Offset(x, dodeY);
      _paintDot(canvas,offset);
      y = rateInGrid;
    }
    return path;
  }

  _paintDot(Canvas canvas, Offset offset){
    const dotRadius = 2.5;
    final dodPaint = Paint()
      ..strokeWidth = 1
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(offset, dotRadius, dodPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
