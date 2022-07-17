import 'package:flutter_currency/domain/entities/currency.dart';
import 'package:flutter_currency/domain/repositories/converter_repository.dart';
import 'package:flutter_currency/domain/use_cases/use_case.dart';

class FetchConverterData extends UseCase<ConverterRepository, void> {
  FetchConverterData({required ConverterRepository repository})
      : super(repository);

  @override
  List<ConverterData> call({void params}) => repository.fetchConverterData();
}
