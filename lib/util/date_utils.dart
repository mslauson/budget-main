class DateUtils {
  DateUtils._();

  static String _currentDateIso() {
    DateTime _now = DateTime.now();
    return _now.toIso8601String().split("T")[0];
  }

  static String _currentFirstOfMonth() {
    DateTime _now = DateTime.now();
    DateTime _firstOfMonth = DateTime(_now.year, _now.month, 1);
    return _firstOfMonth.toIso8601String().split("T")[0];
  }
}
