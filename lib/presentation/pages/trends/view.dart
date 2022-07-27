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
            return MonthTrends(
              trends: logic.trends,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('1'),
          Text('1'),
          Text('1'),
          Text('1'),
          Text('1'),
        ],
      ),
    );
  }
}

class TrendsPainter extends CustomPainter {
  final List<CurrencyTrend> trends;

  TrendsPainter({required this.trends});

  @override
  void paint(Canvas canvas, Size size) {
    const padding = 10.0;

    final trendPaint = Paint()
      ..strokeWidth = 2
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke;

    final trendBorder = Paint()
      ..strokeWidth = 1
      ..color = Colors.blueGrey
      ..style = PaintingStyle.stroke;

    final border = _paintGrid(size, padding);
    canvas.drawPath(border, trendBorder);

    final trendsPath = _paintTrends(size, canvas, padding);
    canvas.drawPath(trendsPath, trendPaint);
  }

  Path _paintGrid(Size size, double padding) {
    final path = Path();
    final border = Rect.fromLTWH(
        padding, padding, size.width - padding * 2, size.height - padding * 2);
    path.addRect(border);
    final quarterOfPeriod = border.height / 4;
    for (var i = 1; i < 4; i++) {
      final period = quarterOfPeriod * i;
      path.moveTo(border.left + period, padding);
      path.relativeLineTo(0.0, border.height);

      path.moveTo(padding, border.top + period);
      path.relativeLineTo(border.width, 0.0);
    }
    return path;
  }

  Path _paintTrends(Size size, Canvas canvas, double padding) {
    final oneDayOnCanvas = (size.width - padding * 2) / (trends.length - 1);
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
      final rateInGrid =
          (size.width - padding * 2) * (element.rate - min) / (max - min);
      if (y == 0.0 && x == 0.0) {
        y = size.height - rateInGrid;
        path.moveTo(padding, y);
      } else {
        x += oneDayOnCanvas.toDouble();
        y -= rateInGrid;
        path.relativeLineTo(oneDayOnCanvas, y);
      }

      final dodeY = size.height - rateInGrid;
      final offset = Offset(x + padding, dodeY);
      _paintDot(canvas, offset);
      y = rateInGrid;
    }
    return path;
  }

  _paintDot(Canvas canvas, Offset offset) {
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
