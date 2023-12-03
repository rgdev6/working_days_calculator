import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../../utils/date_utils.dart";
import "../../utils/uf.dart";
import "../cubit/calculator_cubit.dart";
import "../widgets/brazil_states_dropdown_button.dart";
import "../widgets/date_field.dart";

import "../widgets/date_to_update_segmented_button.dart";
import "../widgets/increment_panel.dart";

class CalculatorView extends StatelessWidget {
  CalculatorView({super.key});

  final initialDateController = TextEditingController();
  final lastDateController = TextEditingController();
  DateToUpdate _dateToIncrement = DateToUpdate.ending;
  BrazilStates _currentState = BrazilStates.SP;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Calculadora de dias úteis"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Builder(builder: (context) {
                return Center(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: DateField(
                              textEditingController: initialDateController,
                              labelText: "Data Inicial",
                              date: DateTime.now(),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: DateField(
                              textEditingController: lastDateController,
                              labelText: "Data Final",
                              date: DateTime.now(),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      BlocBuilder<CalculatorCubit, ({int days, String holidays})>(
                          builder: (context, state) {
                        return Column(
                          children: [
                            IncrementPanel(
                              counter: state.days,
                              onIncrement: () {
                                if (_dateToIncrement == DateToUpdate.initial) {
                                  var date = parse(initialDateController.text);
                                  date = date.add(const Duration(days: 1));
                                  initialDateController.text  = format(date);
                                } else {
                                  var date = parse(lastDateController.text);
                                  date = date.add(const Duration(days: 1));
                                  lastDateController.text  = format(date);
                                }
                                context
                                    .read<CalculatorCubit>()
                                    .calculateDifference(parse(initialDateController.text),
                                    parse(lastDateController.text),
                                    state: BrazilStates.SP);
                              },
                              onDecrement: () {
                                if (_dateToIncrement == DateToUpdate.initial) {
                                  var date = parse(initialDateController.text);
                                  date.subtract(const Duration(days: 1));
                                  initialDateController.text  = format(date);
                                } else {
                                  var date = parse(lastDateController.text);
                                  date = date.subtract(const Duration(days: 1));
                                  lastDateController.text  = format(date);
                                }
                                context
                                    .read<CalculatorCubit>()
                                    .calculateDifference(parse(initialDateController.text),
                                    parse(lastDateController.text),
                                    state: BrazilStates.SP);
                              },
                            ),
                          ],
                        );
                      }),
                      Column(
                        children: [
                          DateToUpdateSegmentedButton(onSelectionChanged: (dates) {
                            _dateToIncrement = dates.first;
                          },),
                          const SizedBox(height: 20,),
                          BrazilStatesDropdownButton(
                            onSelectionChanged: (state) {
                              _currentState = state;
                            },
                          ),
                        ],
                      ),
                      const Spacer(),
                      BlocBuilder<CalculatorCubit, ({int days, String holidays})>(
                      builder: (context, state) {
                        return Text(state.holidays);
                      }),
                      FloatingActionButton.extended(
                          onPressed: () {
                            context
                                .read<CalculatorCubit>()
                                .calculateDifference(parse(initialDateController.text),
                                parse(lastDateController.text),
                                state: BrazilStates.SP);
                          },
                          icon: const Icon(Icons.calculate),
                          label: const Text("Calcular diferença"))
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}


