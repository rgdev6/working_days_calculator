import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:http/http.dart" as http;
import "package:intl/date_symbol_data_local.dart";

import "calculator/repository/holidays_repository.dart";
import "calculator/service/holidays_service.dart";
import "calculator/view/calculator_page.dart";

void main() {
  setUpDependencies();
  initializeDateFormatting("pt-BR").then((value) => runApp(const MyApp()));
}

void setUpDependencies(){
  GetIt.I.registerSingleton<http.Client>(http.Client());
  GetIt.I.registerSingleton<HolidayServiceApi>(HolidayServiceApi());
  GetIt.I.registerSingleton<HolidaysRepository>(HolidaysRepository());
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
