import "package:intl/intl.dart";
import "../calculator/model/holiday_model.dart";
import "extensions/date_extensions.dart";

import "exceptions/date_exceptions.dart";
import "uf.dart";

DateTime parse(String date) {
  return DateFormat.yMd("pt-BR").parse(date);
}

DateTime parseStrict(String date) {
  return DateFormat.yMd("pt-BR").parseStrict(date);
}

String format(DateTime date) {
  return DateFormat.yMd("pt-BR").format(date);
}

int calculateDifference(DateTime startDate, DateTime endDate) {
  int difference = endDate.difference(startDate).inDays;
  return difference;
}

({int days, List<HolidayModel> holidays}) calculateWorkingDays(
    DateTime initialDate, DateTime finalDate, List<HolidayModel> holidays,
    {BrazilStates? state}) {
  if (initialDate.isAfter(finalDate)) {
    throw StarDateAfterException("Start date after end date");
  }

  initialDate = initialDate.copyWith(
      hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  finalDate = finalDate.copyWith(hour: 24, minute: 59, second: 59);

  int difference = calculateDifference(initialDate, finalDate);

  int weekends = countWeekendsInRange(difference, initialDate, finalDate);

  var matchedHolidays = holidays
      .where((holiday) =>
          (holiday.parseDate().isBetween(initialDate, finalDate) ||
              holiday.parseDate().isAtSameDay(initialDate)) &&
          holiday.parseDate().isAtWeek())
      .toList();

  int workingDays = difference - matchedHolidays.length - weekends;
  return (days: workingDays, holidays: matchedHolidays);
}

int countWeekendsInRange(int interval, DateTime initialDate, DateTime finalDate) {
  int numberOfWeeks = interval ~/ DateTime.daysPerWeek;
  int weekends = 2 * numberOfWeeks;
  var days = interval % 7;
  if (days > 0 && (initialDate.isAtWeekend() || finalDate.isAtWeekend())) {
    weekends++;
    return weekends;
  }
  var date = initialDate;
  for (var i = 0; i < days; ++i) {
    if (date.isAtWeekend()) {
      weekends++;
    }
    date = date.add(const Duration(days: 1));
  }

  return weekends;
}