import 'package:flutter_currency/app/constants.dart';
import 'package:flutter_currency/domain/entities/currency.dart';
import 'package:flutter_currency/domain/use_cases/fetch_converter_data.dart';
import 'package:get/get.dart';
import 'package:flutter_currency/presentation/controllers/converter/state.dart';

const defaultToCurrency = usd;
const defaultFromCurrency = byn;
const defaultAmount = 0;

class CalculatorLogic extends GetxController with StateMixin<CalculatorState> {
  final FetchConverterData fetchConverterData;

  CalculatorLogic({
    required this.fetchConverterData,
  });

  RxInt toCurrencyId = defaultToCurrency.obs;
  RxInt fromCurrencyId = defaultFromCurrency.obs;
  Rx<CalculatingResult?> exchangeResult = Rx<CalculatingResult?>(null);

  late ConverterData _exchangeFrom;
  late ConverterData _exchangeTo; //todo initialize

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  void _init() {
    change(null, status: RxStatus.loading());
    final List<ConverterData> data = fetchConverterData();
    _exchangeFrom = data.firstWhere((element) => element.id == fromCurrencyId.value);
    _exchangeTo = data.firstWhere((element) => element.id == toCurrencyId.value);
    change(CalculatorState(data: data), status: RxStatus.success());
  }

  void fromCurrency(ConverterData from) {
    _exchangeFrom = from;
    fromCurrencyId.value = from.id;
  }

  void toCurrency(ConverterData to) {
    _exchangeTo = to;
    toCurrencyId.value = to.id;
  }

  void onTextChange(String amount) {
    final int fromAmount = amount.isEmpty ? 0 : int.parse(amount);
    exchangeResult.value = CalculatingResult(
        fromAmount: fromAmount,
        fromAbr: _exchangeFrom.curAbbr,
        toAmount:
            (_exchangeTo.rateToByRub / _exchangeFrom.rateToByRub) * fromAmount,
        toAbr: _exchangeTo.curAbbr);
  }

  @override
  void onClose() {
    //todo save last currency to exchange
    super.onClose();
  }
}

class CalculatingResult {
  final int fromAmount;
  final String fromAbr;
  final double toAmount;
  final String toAbr;

  const CalculatingResult({
    required this.fromAmount,
    required this.fromAbr,
    required this.toAmount,
    required this.toAbr,
  });
}
