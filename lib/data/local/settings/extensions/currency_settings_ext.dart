import 'package:flutter_currency/data/models/currency_api.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';

extension CreateSettings on List<CurrencyApi> {
  List<RateSettings> createSettings() {
    return List<RateSettings>.generate(
      length,
      (index) {
        return RateSettings(
          curAbbr: this[index].curAbbr,
          curScale: this[index].curScale,
          curName: this[index].curName,
          id: this[index].curId,
          listPos: index,
          isShow: this[index]._isDefaultItem(),
        );
      },
    );
  }
}

extension CheckItem on CurrencyApi {
  bool _isDefaultItem() {
    final showAsDefault = [431, 451, 456];
    return showAsDefault.contains(curId);
  }
}
