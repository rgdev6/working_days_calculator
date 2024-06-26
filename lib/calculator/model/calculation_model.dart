import "../../utils/date_utils.dart";
import "../../utils/uf.dart";
import "holiday_model.dart";

class CalculationModel {
  CalculationModel({
    required this.initialDate,
    required this.finalDate,
    required this.differenceInDays,
    required this.holidays,
    required this.brazilState
  });

  final DateTime initialDate;
  final DateTime finalDate;
  final int differenceInDays;
  final List<HolidayModel> holidays;
  final BrazilStates brazilState;

  String formatInitialDate() => format(initialDate);
  String formatFinalDate() => format(finalDate);

  CalculationModel copyWith({
    DateTime? initialDate,
    DateTime? finalDate,
    int? differenceInDays,
    final List<HolidayModel>? holidays,
    BrazilStates? brazilState,
  }) {
    return CalculationModel(
      initialDate: initialDate ?? this.initialDate,
      finalDate: finalDate ?? this.finalDate,
      differenceInDays: differenceInDays ?? this.differenceInDays,
      holidays: holidays ?? this.holidays,
      brazilState: brazilState ?? this.brazilState
    );
  }
}
