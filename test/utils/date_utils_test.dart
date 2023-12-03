import "package:flutter_test/flutter_test.dart";
import "package:intl/date_symbol_data_local.dart";
import "package:working_days_calculator/utils/date_utils.dart";

void main() {
  group("calculation", () {
    setUp(() async {
      await initializeDateFormatting("pt-BR");
    });
    test("Check if the difference between two dates", () {
      int result = calculateDifference(
          DateTime.now().subtract(const Duration(days: 1)), DateTime.now());
      expect(result, 1);
    });
    test("Check if the holidays are correctly subtracted", () {
      ({int days, String holidays}) result = calculateWorkingDays(
          parse("11/10/2023"), parse("31/10/2023"));
      expect(result.days, 14);
    });
    test("Check if the weekends are correctly subtracted", () {
      ({int days, String holidays}) result = calculateWorkingDays(
          parse("04/10/2023"), parse("11/10/2023"));
      expect(result.days, 5);
    });
    test("Check if the number of workind days in october are correctly", () {
      ({int days, String holidays}) result = calculateWorkingDays(
          parse("01/10/2023"), parse("31/10/2023"));
      expect(result.days, 21);
    });
    test("if holyday are not double counted when at weeknd", () {
      ({int days, String holidays}) result = calculateWorkingDays(
          //25/12/2016 is a saturday
          parse("21/12/2016"), parse("28/12/2016"));
      expect(result.days, 6);
    });
    test("get holidays for october", () {
      final holidays = listHolidaysByMonth(5, 2023);
      expect(holidays, hasLength(1));
    });
  });
}
