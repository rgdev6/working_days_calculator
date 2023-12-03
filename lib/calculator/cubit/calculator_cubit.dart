import "package:bloc/bloc.dart";

import "../../utils/date_utils.dart";
import "../../utils/uf.dart";

class CalculatorCubit extends Cubit<({int days, String holidays})> {
  CalculatorCubit() : super((days: 0, holidays: ""));

  void calculateDifference (DateTime startDate, DateTime endDate, {BrazilStates? state}) {
    ({int days, String holidays}) result = calculateWorkingDays(
        startDate,
        endDate,
        state: state
    );
    emit(result);
  }}
