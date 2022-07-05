import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/entities/rate.dart';

class RateItem extends StatelessWidget {
  const RateItem({
    Key? key,
    required this.rate,
    required this.isTomorrowRatesExist,
  }) : super(key: key);
  final Rate rate;
  final bool isTomorrowRatesExist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rate.curAbbr),
                Text("${rate.curScale} ${rate.curName}"),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isTomorrowRatesExist
                    ? rate.actualCurRate.toString()
                    : rate.alternativeCurRate.toString()),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isTomorrowRatesExist
                    ? rate.alternativeCurRate.toString()
                    : rate.actualCurRate.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}