import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import 'package:working_days_calculator/calculator/model/calculation_model.dart';
import "package:working_days_calculator/calculator/calculator.dart";
import "package:working_days_calculator/utils/uf.dart";

void main() {
  group("CalculatorCubit", () {
    blocTest(
      "emits [1] when CounterIncrementPressed is added",
      build: () => CalculatorCubit(),
      act: (bloc) => bloc.calculateByDateRange(
          DateTime.now(), DateTime.now().add(const Duration(days: 1))),
      expect: () => [CalculationModel(
          initialDate: DateTime.now(),
          finalDate: DateTime.now(),
          differenceInDays: 1,
          holidays: "",
          brazilState: BrazilStates.SP)],
    );
  });
}
