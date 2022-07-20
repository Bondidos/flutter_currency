import 'package:flutter_currency/domain/repositories/trends_repository.dart';
import 'package:flutter_currency/domain/use_cases/use_case.dart';

class FetchSixMonthsTrends extends UseCase<CurrencyTrendsRepository, int> {
  FetchSixMonthsTrends({required CurrencyTrendsRepository repository})
      : super(repository);

  @override
  void call({int params = 0}) => repository.sixMonthPeriod(params);
}
