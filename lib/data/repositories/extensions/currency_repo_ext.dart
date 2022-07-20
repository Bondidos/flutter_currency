import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';

extension ApplySettings on RatesOnDate {
  RatesOnDate applySettings(List<RateSettings> settings) {
    final List<RateSettings> itemsSettings = settings.pickItemsAndSort();
    final List<Rate> rates = _applySettings(itemsSettings);
    return RatesOnDate(
      rates: rates,
      currentDate: currentDate,
      alternativeDate: alternativeDate,
      isTomorrowRatesExists: isTomorrowRatesExists,
    );
  }

  List<Rate> _applySettings(List<RateSettings> itemsSettings) => List.generate(
      itemsSettings.length,
      (index) =>
          rates.firstWhere((e) => e.curId == itemsSettings[index].id));
}

extension FilterSettings on List<RateSettings> {
  List<RateSettings> pickItemsAndSort() {
    final List<RateSettings> pickedItems =
        where((element) => element.isShow == true).toList();
    pickedItems.sort((a, b) => a.listPos.compareTo(b.listPos));
    return pickedItems;
  }
}
