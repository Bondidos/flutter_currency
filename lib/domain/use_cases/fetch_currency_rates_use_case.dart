import 'package:flutter_currency/domain/entities/rates_on_date.dart';
import 'package:flutter_currency/domain/repositories/currency_repository.dart';
import 'package:flutter_currency/domain/use_cases/use_case.dart';

class FetchCurrencyRates extends UseCase<CurrencyRepository, void> {
  FetchCurrencyRates({required CurrencyRepository repository})
      : super(repository);

  @override
  Stream<RatesOnDate?> call({params}) => repository.fetchRates();
}
