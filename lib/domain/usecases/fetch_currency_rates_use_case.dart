import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/repositories/currency_repository.dart';

class FetchCurrencyRatesUseCase {
  final CurrencyRepository repository;

  const FetchCurrencyRatesUseCase({
    required this.repository,
  });

  Future<List<Rate>> call() => repository.fetchRates();
}