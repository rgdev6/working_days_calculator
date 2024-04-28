import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../../utils/date_utils.dart";
import "../../utils/uf.dart";
import "../calculation_model.dart";
import "../cubit/calculator_cubit.dart";
import "../widgets/brazil_states_dropdown_button.dart";
import "../widgets/date_field.dart";

import "../widgets/date_to_update_segmented_button.dart";
import "../widgets/historyBottomSheet.dart";
import "../widgets/increment_panel.dart";

class CalculatorView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final initialDateController = TextEditingController();

  final lastDateController = TextEditingController();

  DateToUpdate _dateToUpdate = DateToUpdate.Final;

  BrazilStates _currentState = BrazilStates.SP;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Exibir histórico de calculos',
            onPressed: () {
              scaffoldKey.currentState?.showBottomSheet(
                (BuildContext context) {
                  var history =
                      context.read<CalculatorCubit>().history.reversed.toList();
                  return HistoryBottomSheet(calculationHistory: history);
                },
              );
            },
          ),
        ],
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
                      BlocListener<CalculatorCubit, CalculationModel>(
                        listener: (context, state) {
                          initialDateController.text = state.formatInitialDate();
                          lastDateController.text = state.formatFinalDate();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: DateField(
                                textEditingController: initialDateController,
                                labelText: "Data Inicial",
                                date: DateTime.now(),
                                onIncrement: () => context
                                    .read<CalculatorCubit>()
                                    .incrementInitialDate(),
                                onDecrement: () => context
                                    .read<CalculatorCubit>()
                                    .decrementInitialDate(),
                                onDateSelect: () => context
                                    .read<CalculatorCubit>()
                                    .calculateByDateRange(
                                        parse(initialDateController.text),
                                        parse(lastDateController.text)),
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
                                  onIncrement: () => context
                                      .read<CalculatorCubit>()
                                      .incrementFinalDate(),
                                  onDecrement: () => context
                                      .read<CalculatorCubit>()
                                      .decrementFinalDate(),
                                  onDateSelect: () => context
                                      .read<CalculatorCubit>()
                                      .calculateByDateRange(
                                          parse(initialDateController.text),
                                          parse(lastDateController.text))),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      BlocBuilder<CalculatorCubit, CalculationModel>(
                          builder: (context, state) {
                        return Column(
                          children: [
                            IncrementPanel(
                              counter: state.differenceInDays,
                              onIncrement: () {
                                if (_dateToUpdate == DateToUpdate.Final) {
                                  context
                                      .read<CalculatorCubit>()
                                      .incrementFinalDate();
                                } else {
                                  context
                                      .read<CalculatorCubit>()
                                      .incrementInitialDate();
                                }
                              },
                              onDecrement: () {
                                if (_dateToUpdate == DateToUpdate.Final) {
                                  context
                                      .read<CalculatorCubit>()
                                      .decrementFinalDate();
                                } else {
                                  context
                                      .read<CalculatorCubit>()
                                      .decrementInitialDate();
                                }
                              },
                            ),
                          ],
                        );
                      }),
                      Column(
                        children: [
                          DateToUpdateSegmentedButton(
                            onSelectionChanged: (dates) {
                              _dateToUpdate = dates.first;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BrazilStatesDropdownButton(
                            onSelectionChanged: (state) {
                              _currentState = state;
                              context
                                  .read<CalculatorCubit>()
                                  .updateBrazilState(state);
                            },
                          ),
                        ],
                      ),
                      BlocBuilder<CalculatorCubit, CalculationModel>(
                          builder: (context, state) {
                        return Text(state.holidays);
                      }),
                      const Spacer(),
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
