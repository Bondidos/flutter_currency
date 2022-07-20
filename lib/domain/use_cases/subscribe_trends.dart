import 'package:flutter_currency/domain/entities/currency_trend.dart';
import 'package:flutter_currency/domain/repositories/trends_repository.dart';
import 'package:flutter_currency/domain/use_cases/use_case.dart';

class SubscribeTrends extends UseCase<CurrencyTrendsRepository,void>{
  SubscribeTrends(super.repository);

  @override
  Stream<List<CurrencyTrend>?> call({void params}) => repository.subscribeTrends();
}