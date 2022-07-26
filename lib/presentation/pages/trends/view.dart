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
    return SizedBox(
      height: Get.width,
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomPaint(
          painter: TrendsPainter(trends: trends),
        ),
      ),
    );
  }
}

class TrendsPainter extends CustomPainter {
  final List<CurrencyTrend> trends;

  TrendsPainter({required this.trends});

  @override
  void paint(Canvas canvas, Size size) {

    final trendPaint = Paint()
      ..strokeWidth = 2
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke;

    final trendBorder = Paint()
      ..strokeWidth = 1
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    final border = _paintBorders(size);
    canvas.drawRect(border, trendBorder);

    final trendsPath = _paintTrends(size);
    canvas.drawPath(trendsPath, trendPaint);
  }

  Rect _paintBorders(Size size){
    return Rect.fromLTWH(0.0, 0.0, size.width, size.height);
  }

  Path _paintTrends(Size size) {
    final oneDayOnCanvas = size.width / (trends.length -1);
    var max = 0.0;
    var min = double.infinity;
    for (var element in trends) {
      if(element.rate > max) max = element.rate.ceil().toDouble();
      if(element.rate < min) min = element.rate.toInt().toDouble();
    }
    print(min);

    final path = Path();
    var y = 0.0;
    var x = 0.0;
    final rateOnCanvas = size.height / (max + max);
    print(rateOnCanvas);

    for(var element in trends){
      if(y == 0.0 && x == 0.0) {
        y = size.height - rateOnCanvas * element.rate;
        path.moveTo(x, y);
      } else {
        x = oneDayOnCanvas.toDouble();
        y -= (rateOnCanvas * element.rate);
        path.relativeLineTo(x, y);
      }
      y = (rateOnCanvas * element.rate);
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
