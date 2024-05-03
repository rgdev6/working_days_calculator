extension HolydaysValidation on DateTime {
  bool isBetween(DateTime startDate, DateTime endDate) {
    return isAfter(startDate) && isBefore(endDate);
  }

  bool isAtWeekend() => weekday == 6 || weekday == 7;

  bool isAtWeek() => weekday != 6 && weekday != 7;

  bool isAtSameDay(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  List<int> getYearsRange(DateTime endDate) {
    List<int> years = [];
    for (int i = year; i <= endDate.year; ++i) {
      years.add(i);
    }
    return years;
  }
}