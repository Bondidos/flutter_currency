import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';
import 'package:flutter_currency/domain/entities/rates_on_date.dart';

extension ApplySettings on RatesOnDate {
  RatesOnDate applySettings(List<RateSettings> settings) {
    final List<RateSettings> itemsSettings =
        settings.where((element) => element.isShow == true).toList();
    itemsSettings.sort((a, b) => a.listPos.compareTo(b.listPos));
    final List<Rate> rates = List.generate(
        itemsSettings.length,
        (index) =>
            this.rates.firstWhere((e) => e.curId == itemsSettings[index].id));
  }
}
