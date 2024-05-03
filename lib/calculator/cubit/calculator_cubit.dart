import "package:bloc/bloc.dart";
import "package:get_it/get_it.dart";

import "../../utils/date_utils.dart";
import "../../utils/extensions/date_extensions.dart";
import "../../utils/uf.dart";
import "../model/calculation_model.dart";
import "../model/holiday_model.dart";
import "../repository/holidays_repository.dart";

class CalculatorCubit extends Cubit<CalculationModel> {
  CalculatorCubit()
      : super(CalculationModel(
            initialDate: DateTime.now(),
            finalDate: DateTime.now(),
            differenceInDays: 0,
            holidays: [],
            brazilState: BrazilStates.SP));

  List<CalculationModel> history = [];

  final HolidaysRepository holidayRepository = GetIt.I.get<HolidaysRepository>();

  void updateBrazilState(BrazilStates brazilState) {
    var newCalculation = state.copyWith(brazilState: brazilState);
    _calculate(newCalculation);
  }

  void decrementInitialDate() {
    var newCalculation = state.copyWith(
        initialDate: state.initialDate.subtract(const Duration(days: 1)));
    _calculate(newCalculation);
  }

  void incrementInitialDate() {
    var newCalculation = state.copyWith(
        initialDate: state.initialDate.add(const Duration(days: 1)));
    _calculate(newCalculation);
  }

  void decrementFinalDate() {
    var newCalculation = state.copyWith(
        finalDate: state.finalDate.subtract(const Duration(days: 1)));
    _calculate(newCalculation);
  }

  void incrementFinalDate() {
    var newCalculation =
        state.copyWith(finalDate: state.finalDate.add(const Duration(days: 1)));
    _calculate(newCalculation);
  }

  void calculateByDateRange(DateTime initialDate, DateTime finalDate) {
    var newCalculation =
        state.copyWith(initialDate: initialDate, finalDate: finalDate);
    _calculate(newCalculation);
  }

  void _calculate(CalculationModel calculation) async {
    List<HolidayModel> holidaysList = [];
    var yearsRange = calculation.initialDate
        .getYearsRange(calculation.finalDate);

    for (var year = yearsRange.first; year <= yearsRange.last; ++year) {
      var holidays = await holidayRepository.fetchData(
          year: year, state: BrazilStates.SP.name);
      holidaysList.addAll(holidays);
    }
    var result = calculateWorkingDays(
        calculation.initialDate, calculation.finalDate, holidaysList,
        state: BrazilStates.SP);

    emit(calculation.copyWith(
        differenceInDays: result.days, holidays: result.holidays));

    history.add(calculation);
  }
}
