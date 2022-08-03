import 'package:flutter_currency/domain/repositories/trends_repository.dart';
import 'package:flutter_currency/domain/use_cases/use_case.dart';

class FetchMonthTrends extends UseCase<CurrencyTrendsRepository, int> {
  FetchMonthTrends({required CurrencyTrendsRepository repository})
      : super(repository);

  @override
  void call({int? params}) => repository.monthPeriod();
}
