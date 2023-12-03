import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:intl/date_symbol_data_local.dart";
import "package:working_days_calculator/calculator/widgets/date_field.dart";
import "package:working_days_calculator/main.dart";
import "package:working_days_calculator/utils/date_utils.dart";

void main() {
  group("Test basic interactions", () {
    setUp(() async {
      await initializeDateFormatting("pt-BR");
    });
    testWidgets(
        "Enter valid dates and verify if the difference is properly calculated",
        (tester) async {
      await tester.pumpWidget(const MyApp());

      var textFields = find.byType(DateField);
      final startDateField = textFields.first;
      final endDateField = textFields.last;

      await tester.enterText(startDateField, "20/02/1998");
      await tester.enterText(endDateField, "21/02/1998");

      var calculateButton = find.text("Calcular diferença");
      await tester.tap(calculateButton);

      await tester.pumpAndSettle();

      expect(find.text("1"), findsOneWidget);
    }, skip: true);

    testWidgets("Increment the counter and update the Start Date field",
        (tester) async {
      await tester.pumpWidget(const MyApp());

      var incrementButton = find.byIcon(Icons.add);

      await tester.tap(incrementButton);

      await tester.pumpAndSettle();

      var updateText = format(DateTime.now().add(const Duration(days: 1)));
      expect(find.
      text(updateText), findsOneWidget);
    });
  });

  // testWidgets('tap on the floating action button, verify counter',
  //         (tester) async {
  //       // Load app widget.
  //       await initializeDateFormatting("pt-BR");
  //       await tester.pumpWidget(const MyApp());
  //
  //       // Verify the counter starts at 0.
  //       expect(find.text('0'), findsOneWidget);
  //
  //       // Finds the floating action button to tap on.
  //       //final fab = find.byKey(const Key('increment'));
  //       final fab = find.widgetWithIcon(FloatingActionButton, Icons.calculate);
  //       // Emulate a tap on the floating action button.
  //       await tester.tap(fab);
  //
  //       // Trigger a frame.
  //       await tester.pumpAndSettle();
  //
  //       // Verify the counter increments by 1.
  //       expect(find.text('0'), findsNothing);
  //       expect(find.text('1'), findsOneWidget);
  //     });
}
