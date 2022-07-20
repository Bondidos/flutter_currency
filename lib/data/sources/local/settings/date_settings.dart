abstract class DateSettings {
  void setCurrentDate(DateTime date);

  void setAlternativeDate(DateTime date);

  DateTime get currentDate;

  DateTime get alternativeDate;

  bool get isTomorrowRatesExists;

  bool get isCurrentDateActual;
}