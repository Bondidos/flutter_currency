import 'package:flutter/material.dart';

class DatePanel extends StatelessWidget {
  const DatePanel({
    Key? key,
    required this.currentDate,
    required this.alternativeDate,
    required this.isTomorrowRatesExists,
  }) : super(key: key);
  final String currentDate;
  final String alternativeDate;
  final bool isTomorrowRatesExists;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          const Expanded(
            flex: 2,
            child: SizedBox.shrink(),
          ),
          Expanded(
            flex: 1,
            child: Text(isTomorrowRatesExists ? currentDate : alternativeDate),
          ),
          Expanded(
            flex: 1,
            child: Text(isTomorrowRatesExists ? alternativeDate : currentDate),
          )
        ],
      ),
    );
  }
}
