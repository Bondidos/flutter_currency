abstract class CurrencySettings{
  Future<void> createSettings(Map<String,bool> settings);
  Map<String,dynamic> fetchSettings();
}