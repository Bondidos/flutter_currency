import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:flutter_currency/domain/repositories/currency_repository.dart';

class FetchCurrencyRatesUseCase {
  final CurrencyRepository repository;

  const FetchCurrencyRatesUseCase({
    required this.repository,
  });

  Future<RatesOnDate> call() => repository.fetchRates();
}