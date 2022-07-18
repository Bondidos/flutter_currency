import 'dart:async';
import 'package:flutter_currency/domain/entities/converter_settings.dart';
import 'package:flutter_currency/domain/entities/currency.dart';
import 'package:flutter_currency/domain/use_cases/fetch_converter_data.dart';
import 'package:flutter_currency/domain/use_cases/save_converter_settings.dart';
import 'package:flutter_currency/domain/use_cases/subscribe_converter_settings.dart';
import 'package:flutter_currency/presentation/controllers/converter/calculation_result.dart';
import 'package:get/get.dart';
import 'package:flutter_currency/presentation/controllers/converter/state.dart';

const defaultAmount = 1;

class CalculatorLogic extends GetxController with StateMixin<ConverterState> {
  final FetchConverterData fetchConverterData;
  final SaveConverterSettings saveSettings;
  final SubscribeConverterSettings subscribeSettings;

  CalculatorLogic({
    required this.fetchConverterData,
    required this.saveSettings,
    required this.subscribeSettings,
  });

  final Rx<ConverterData?> fromCurrency = Rx<ConverterData?>(null);
  final Rx<ConverterData?> toCurrency = Rx<ConverterData?>(null);
  final RxInt _amountBuffer = RxInt(defaultAmount);

  Rx<CalculatingResult>? exchangeResult;
  StreamSubscription<ConverterSettings>? settingsStream;

  @override
  void onInit() {
    _init();
    debounce(
      _amountBuffer,
      time: const Duration(milliseconds: 500),
          (callback) => exchangeResult?.value = _calculate(),
    );

    super.onInit();
  }

  void _init() {
    change(null, status: RxStatus.loading());
    final List<ConverterData> data = fetchConverterData();
    settingsStream = subscribeSettings().listen((settings) {
      fromCurrency.value =
          data.firstWhere((element) => element.id == settings.fromCurrencyId);
      toCurrency.value =
          data.firstWhere((element) => element.id == settings.toCurrencyId);
    });
    exchangeResult = Rx<CalculatingResult>(_calculate());
    change(ConverterState(data: data), status: RxStatus.success());
  }

  void setFromCurrency(ConverterData from) {
    // fromCurrency.value = from;
    saveSettings(params: _createSettings(from: from.id,to: null));
  }

  void setToCurrency(ConverterData to) {
    // toCurrency.value = to;
    saveSettings(params: _createSettings(to: to.id,from: null));
  }

  void onTextChange(String amount) {
    final int intAmount = amount.isEmpty ? 1 : int.parse(amount);
    _amountBuffer.value = intAmount;
  }

  ConverterSettings _createSettings({required int? from, required int? to}) => ConverterSettings(
    fromCurrencyId: from ?? fromCurrency.value?.id ?? 0,
    toCurrencyId: to ?? toCurrency.value?.id ?? 0,
  );

  CalculatingResult _calculate() {
    double fromCurrencyRate = fromCurrency.value?.rateToByRub ?? 1;
    double toCurrencyRate = toCurrency.value?.rateToByRub ?? 1;
    var calculated = (toCurrencyRate / fromCurrencyRate) * _amountBuffer.value;

    return CalculatingResult(
      fromAmountAndAbr:
      "${_amountBuffer.value} ${fromCurrency.value?.curAbbr} =",
      toAmountAndAbr: "$calculated ${toCurrency.value?.curAbbr}",
    );
  }

  @override
  void onClose() {
    //todo save last currency to exchange
    super.onClose();
  }
}
