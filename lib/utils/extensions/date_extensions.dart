extension HolydaysValidation on DateTime {
  bool isBetween(DateTime startDate, DateTime endDate) {
    return isAfter(startDate) && isBefore(endDate);
  }

  bool isAtWeekend() => weekday == 6 || weekday == 7;

  bool isAtWeek() => weekday != 6 && weekday != 7;
}