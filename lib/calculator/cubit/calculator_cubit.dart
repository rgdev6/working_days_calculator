import "package:bloc/bloc.dart";

import "../../utils/date_utils.dart";
import "../../utils/uf.dart";
import "../calculation_model.dart";

class CalculatorCubit extends Cubit<CalculationModel> {
  CalculatorCubit()
      : super(CalculationModel(
      initialDate: DateTime.now(),
      finalDate: DateTime.now(),
      differenceInDays: 0,
      holidays: "",
      brazilState: BrazilStates.SP));

  List<CalculationModel> history = [];

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

  void _calculate(CalculationModel calculation) {
    var result = calculateWorkingDays(
        calculation.initialDate, calculation.finalDate,
        state: BrazilStates.SP);
    emit(calculation.copyWith(
        differenceInDays: result.days, holidays: result.holidays));
    history.add(calculation);
  }
}
