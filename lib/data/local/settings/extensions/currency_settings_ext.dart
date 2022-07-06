import 'package:flutter_currency/domain/entities/rate.dart';

extension CreateSettings on List<Rate> {
  Map<String, bool> createSettings() {
    final showAsDefault = [431, 451, 456];
    return {
      for (var item in this)
        if (showAsDefault.contains(item.curId))
          item.curId.toString(): true
        else
          item.curId.toString(): false
    };
  }
}
