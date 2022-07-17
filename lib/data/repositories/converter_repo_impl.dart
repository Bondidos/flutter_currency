import 'package:flutter_currency/data/repositories/extensions/converter_repo_ext.dart';
import 'package:flutter_currency/data/sources/local/database/rates_dao.dart';
import 'package:flutter_currency/domain/entities/currency.dart';
import 'package:flutter_currency/domain/repositories/converter_repository.dart';

class ConverterRepositoryImpl implements ConverterRepository {
  final RatesDatastore ratesDao;

  const ConverterRepositoryImpl({
    required this.ratesDao,
  });

  @override
  List<ConverterData> fetchConverterData() =>
      ratesDao.fetchCurrencies().toCurrencyListAndAddBYN();
}
