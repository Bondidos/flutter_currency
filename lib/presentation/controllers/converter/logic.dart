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

class ConverterLogic extends GetxController with StateMixin<ConverterState> {
  final FetchConverterData fetchConverterData;
  final SaveConverterSettings saveSettings;
  final SubscribeConverterSettings subscribeSettings;

  ConverterLogic({
    required this.fetchConverterData,
    required this.saveSettings,
    required this.subscribeSettings,
  });

  final Rx<ConverterData?> fromCurrency = Rx<ConverterData?>(null);
  final Rx<ConverterData?> toCurrency = Rx<ConverterData?>(null);
  final RxInt amountBuffer = RxInt(defaultAmount);

  Rx<CalculationResult>? exchangeResult;
  StreamSubscription<ConverterSettings>? settingsStream;

  @override
  void onInit() {
    _init();
    debounce(
      amountBuffer,
      time: const Duration(milliseconds: 500),
      (_) => _calculateAndEmitResult(),
    );
    everAll([fromCurrency, toCurrency], (_) => _calculateAndEmitResult());
    super.onInit();
  }

  void _init() {
    change(null, status: RxStatus.loading());
    final List<ConverterData> data = fetchConverterData();
    settingsStream = subscribeSettings()
        .listen((settings) => _applySettings(data, settings));
    exchangeResult = Rx<CalculationResult>(_calculate());
    change(ConverterState(data: data), status: RxStatus.success());
  }

  void _applySettings(List<ConverterData> data, ConverterSettings settings) {
    fromCurrency.value =
        data.firstWhere((element) => element.id == settings.fromCurrencyId);
    toCurrency.value =
        data.firstWhere((element) => element.id == settings.toCurrencyId);
  }

  void setFromCurrency(ConverterData from) =>
      saveSettings(params: _createSettings(from: from.id, to: null));

  void setToCurrency(ConverterData to) =>
      saveSettings(params: _createSettings(to: to.id, from: null));

  ConverterSettings _createSettings({required int? from, required int? to}) =>
      ConverterSettings(
        fromCurrencyId: from ?? fromCurrency.value?.id ?? 0,
        toCurrencyId: to ?? toCurrency.value?.id ?? 0,
      );

  void onTextChange(String amount) {
    final int intAmount = amount.isEmpty ? 1 : int.parse(amount);
    amountBuffer.value = intAmount;
  }

  void _calculateAndEmitResult() => exchangeResult?.value = _calculate();

  CalculationResult _calculate() {
    double fromCurrencyRate = fromCurrency.value?.rateToByRub ?? 1;
    double toCurrencyRate = toCurrency.value?.rateToByRub ?? 1;
    var calculated = (fromCurrencyRate / toCurrencyRate) * amountBuffer.value;

    return CalculationResult(
      fromAmountAndAbr:
          "${amountBuffer.value} ${fromCurrency.value?.curAbbr} =",
      toAmountAndAbr: "${calculated.toPrecision(2)} ${toCurrency.value?.curAbbr}",
      rate: (fromCurrencyRate / toCurrencyRate).toPrecision(2).toString(),
    );
  }

  @override
  void onClose() {
    settingsStream?.cancel();
    super.onClose();
  }
}
