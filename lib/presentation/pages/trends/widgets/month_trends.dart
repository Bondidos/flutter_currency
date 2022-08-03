import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/controllers/trends/state.dart';
import 'package:flutter_currency/presentation/pages/trends/widgets/trends_painter.dart';

class MonthTrends extends StatelessWidget {
  final TrendsState state;

  const MonthTrends({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TrendsPainter(state: state),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: state.dateGrid.map((e) => Text(e)).toList(),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: state.rateGrid.map((e) => Text(e.toString())).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
