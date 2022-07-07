import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/entities/rate_settings.dart';

extension CreateSettings on List<Rate> {
  List<RateSettings> createSettings() {
    final showAsDefault = [431, 451, 456];
    return List<RateSettings>.generate(
      showAsDefault.length,
      (index) {
        Rate rateToShow =
            firstWhere((element) => element.curId == showAsDefault[index]);
        return RateSettings(
          curAbbr: rateToShow.curAbbr,
          curScale: rateToShow.curScale,
          curName: rateToShow.curName,
          id: rateToShow.curId,
          listPos: index,
          isShow: true,
        );
      },
    );
  }
}
