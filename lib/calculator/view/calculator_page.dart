import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../cubit/calculator_cubit.dart";

import "calculator_view.dart";

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalculatorCubit(),
      child: CalculatorView(),
    );
  }
}
