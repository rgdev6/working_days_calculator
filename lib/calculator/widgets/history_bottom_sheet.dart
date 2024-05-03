import "package:flutter/material.dart";

import '../model/calculation_model.dart';

class HistoryBottomSheet extends StatelessWidget {
  const HistoryBottomSheet({super.key, required this.calculationHistory});

  final List<CalculationModel> calculationHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              const Text('Histórico'),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close))))
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: calculationHistory.length,
                itemBuilder: (context, index) {
                  var calculation = calculationHistory[index];
                  return ListTile(
                    subtitle: Text.rich(TextSpan(children: [
                      const TextSpan(
                          text: "Data Inicial: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                        text: "${calculation.formatInitialDate()}\n",
                      ),
                      const TextSpan(
                          text: "Data Final: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "${calculation.formatFinalDate()}\n"),
                      const TextSpan(
                          text: "Diferença: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                        text: calculation.differenceInDays.toString(),
                      ),
                    ])),
                    trailing: Text(calculation.brazilState.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
