import 'package:flutter_currency/data/sources/remote/currency_remote_source.dart';
import 'package:flutter_currency/domain/entities/rate.dart';
import 'package:flutter_currency/domain/repositories/currency_repository.dart';
import 'package:get/get.dart';

class CurrencyRepoImpl extends GetxService implements CurrencyRepository {
  final CurrencyRemoteSource currencyRemoteSource;
  CurrencyRepoImpl({required this.currencyRemoteSource});

  @override
  Future<List<Rate>> fetchRates() => currencyRemoteSource.fetchRates();

}
