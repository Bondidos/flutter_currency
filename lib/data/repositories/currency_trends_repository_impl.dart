import 'package:flutter_currency/data/sources/local/settings/converter_settings_store.dart';
import 'package:flutter_currency/data/sources/remote/currency_remote_source.dart';
import 'package:flutter_currency/domain/entities/currency_trend.dart';
import 'package:flutter_currency/domain/repositories/trends_repository.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CurrencyTrendsRepositoryImpl extends GetxService
    implements CurrencyTrendsRepository {
  final CurrencyRemoteSource remoteSource;
  final ConverterSettingsStore settingsStore;

  CurrencyTrendsRepositoryImpl({
    required this.remoteSource,
    required this.settingsStore,
  });

  // todo this is temporary solution. move streams further

  BehaviorSubject<List<CurrencyTrend>?> subject = BehaviorSubject.seeded(null);

  @override
  void monthPeriod() {
    settingsStore.subscribe().listen(
      (event) {
        subject.addStream(
          Stream.fromFuture(
            remoteSource.fetchTrendsMonth(event.fromCurrencyId),
          ),
        );
      },
    );
  }

  @override
  void sixMonthPeriod(int curId) => subject
      .addStream(Stream.fromFuture(remoteSource.fetchTrendsSixMonths(curId)));

  @override
  Stream<List<CurrencyTrend>?> subscribeTrends() => subject.stream;
}
