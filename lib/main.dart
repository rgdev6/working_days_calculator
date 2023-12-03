import "package:flutter/material.dart";
import "package:intl/date_symbol_data_local.dart";

import "calculator/view/calculator_page.dart";

void main() {
  initializeDateFormatting("pt-BR").then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const CalculatorPage(),
    );
  }
}
