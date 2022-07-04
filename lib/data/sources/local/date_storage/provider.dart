import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract class DateStorage {
  void setCurrentDate(DateTime date);

  void setAlternativeDate(DateTime date);

  DateTime get currentDate;

  DateTime get alternativeDate;

  bool get isTomorrowRatesExists;
}

const alternativeKey = 'alternative';
const currentKey = 'current';

class DataStorageImpl extends GetxService implements DateStorage {

  late GetStorage _storage;
  Future<DataStorageImpl> init() async {
    await GetStorage.init('GetStorage');
    _storage = GetStorage('GetStorage');
    return this;
  }


  // static final _singleton = DataStorageImpl();
  // static DataStorageImpl get instance => _singleton;
//todo convert to ms and write to storage instead of ram
  @override
  DateTime get alternativeDate => _storage.read(alternativeKey);

  @override
  DateTime get currentDate => _storage.read(currentKey);

  @override
  void setAlternativeDate(DateTime date) =>
      _storage.writeInMemory(alternativeKey, date);

  @override
  void setCurrentDate(DateTime date) => _storage.writeInMemory(currentKey, date);

  @override
  bool get isTomorrowRatesExists => currentDate.isBefore(alternativeDate);
}
