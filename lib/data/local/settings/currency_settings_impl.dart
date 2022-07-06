import 'package:flutter_currency/data/sources/local/settings/currency_settings.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

const currencySettingsKey = 'currencySettings';
const Map<String, bool> initialSettings = {
  '431': true,
  '451': true,
  '456': true,
};

class CurrencySettingsImpl extends GetxService implements CurrencySettings {
  final GetStorage currencySettings;

  CurrencySettingsImpl({
    required this.currencySettings,
  });

  @override
  Future<void> createSettings(Map<String, bool> settings) async{
     try{
       await currencySettings.write(currencySettingsKey, settings);
       return;
     }catch(e){
       print(e.toString());
     }
  }

  @override
  Map<String, dynamic> fetchSettings() => currencySettings.read(currencySettingsKey);
}