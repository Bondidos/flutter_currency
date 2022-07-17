import 'package:flutter_currency/domain/entities/currency.dart';

abstract class ConverterRepository{
  List<ConverterData> fetchConverterData();
}