import 'package:intl/intl.dart';

extension DateToString on DateTime {
  String asString() {
    DateFormat format = DateFormat("dd.MM.yyyy");
    return format.format(this);
  }
}