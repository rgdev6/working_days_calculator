import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:working_days_calculator/calculator/calculator.dart";

void main() {
  group("CalculatorCubit", () {
    blocTest(
      "emits [1] when CounterIncrementPressed is added",
      build: () => CalculatorCubit(),
      act: (bloc) => bloc.calculateDifference(
          DateTime.now(), DateTime.now().add(const Duration(days: 1))),
      expect: () => [(days: 1, holidays: "")],
    );
  });
}
