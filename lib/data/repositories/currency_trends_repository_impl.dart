import 'package:flutter_currency/data/sources/remote/currency_remote_source.dart';
import 'package:flutter_currency/domain/entities/currency_trend.dart';
import 'package:flutter_currency/domain/repositories/trends_repository.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CurrencyTrendsRepositoryImpl extends GetxService
    implements CurrencyTrendsRepository {
  final CurrencyRemoteSource remoteSource;

  CurrencyTrendsRepositoryImpl({required this.remoteSource});

  // todo this is temporary solution. move streams further

  BehaviorSubject<List<CurrencyTrend>?> subject = BehaviorSubject.seeded(null);

  @override
  void monthPeriod(int curId) => subject
      .addStream(Stream.fromFuture(remoteSource.fetchTrendsMonth(curId)));

  @override
  void sixMonthPeriod(int curId) => subject
      .addStream(Stream.fromFuture(remoteSource.fetchTrendsSixMonths(curId)));

  @override
  Stream<List<CurrencyTrend>?> subscribeTrends() => subject.stream;
}
