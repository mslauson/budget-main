class DateUtils {
  DateUtils._();

  static String currentDateIso() {
    DateTime _now = DateTime.now();
    _now = DateTime(_now.year, _now.month, _now.day + 1);
    return _now.toIso8601String().split("T")[0];
  }

  static String currentLastOfMonthIso() {
    DateTime _now = DateTime.now();
    DateTime _firstOfMonth = DateTime(_now.year, _now.month, 0);
    return _firstOfMonth.toIso8601String().split("T")[0];
  }

  static String currentFirstOfMonthIso() {
    DateTime _now = DateTime.now();
    DateTime _firstOfMonth = DateTime(_now.year, _now.month, 1);
    return _firstOfMonth.toIso8601String().split("T")[0];
  }
}
