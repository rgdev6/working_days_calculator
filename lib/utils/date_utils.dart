import "package:intl/intl.dart";
import "extensions/date_extensions.dart";

import "exceptions/date_exceptions.dart";
import "uf.dart";

typedef HolidayList = List<({DateTime holidayDate, String holidayName})>  Function({
  DateTime holidayDate,
  String holidayName,
});

DateTime parse(String date) {
  return DateFormat.yMd("pt-BR").parse(date);
}

DateTime parseStrict(String date) {
  return DateFormat.yMd("pt-BR").parseStrict(date);
}

String format(DateTime date) {
  return DateFormat.yMd("pt-BR").format(date);
}

int calculateDifference(DateTime startDate, DateTime endDate) {
  int difference = endDate.difference(startDate).inDays;
  return difference;
}

({int days, String holidays}) calculateWorkingDays(
    DateTime startDate, DateTime endDate, {BrazilStates? state}) {

  if (startDate.isAfter(endDate)) {
    throw StarDateAfterException("Start date after end date");
  }

  startDate = startDate.copyWith(
      hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  endDate = endDate.copyWith(hour: 24, minute: 59, second: 59);

  int difference = calculateDifference(startDate, endDate);

  int weekends = countWeekendsInRange(difference, startDate, endDate);

  int holidays = 0;
  final strBuf = StringBuffer();

  for (var i = startDate.month; i <= endDate.month; ++i) {
    listHolidaysByMonth(i, startDate.year)
        .where((holiday) =>
            holiday.holidayDate.isBetween(startDate, endDate) &&
            holiday.holidayDate.isAtWeek())
        .forEach((holiday) {
      holidays++;
      strBuf.write("\n${holiday.holidayName}");
    });
  }

  if (state != null) {
    for (var i = startDate.month; i <= endDate.month; ++i) {
        listHolidaysByStateAndDate(i, startDate.year, state)
            .where((holiday) =>
        holiday.holidayDate.isBetween(startDate, endDate) &&
            holiday.holidayDate.isAtWeek())
            .forEach((holiday) {
          holidays++;
          strBuf.write("\n${holiday.holidayName}");
        });
      }
  }

  int workingDays = difference - holidays - weekends;
  String holidaysNames = strBuf.toString();
  return (days: workingDays, holidays: holidaysNames);
}

int countWeekendsInRange(
    int interval, DateTime startDate, DateTime endDate) {
  int numberOfWeeks = interval ~/ DateTime.daysPerWeek;
  int weekends = 2 * numberOfWeeks;
  var days = interval % 7;
  if (days > 0 && (startDate.isAtWeekend() || endDate.isAtWeekend())) {
    weekends++;
    return weekends;
  }
  var date = startDate;
  for (var i = 0; i < days; ++i) {
    if (date.isAtWeekend()) {
      weekends++;
    }
    date = date.add(const Duration(days: 1));
  }

  return weekends;
}

List<({DateTime holidayDate, String holidayName})> listHolidaysByMonth(
    int month, int year) {
  List<({DateTime holidayDate, String holidayName})> holidays = [];
  switch (month) {
    case 1:
      holidays.add((
        holidayDate: DateTime.parse("$year-0$month-01"),
        holidayName: "01/01 - Ano Novo"
      ));
    case 4:
      holidays.add((
        holidayDate: DateTime.parse("$year-0$month-02"),
        holidayName: "02/04 - Sexta Feira Santa"
      ));
      holidays.add((
        holidayDate: DateTime.parse("$year-0$month-21"),
        holidayName: "21/04 - Proclamação da República"
      ));
    case 5:
      holidays.add((
        holidayDate: DateTime.parse("$year-0$month-01"),
        holidayName: "01/05 - Dia do Trabalho"
      ));
    case 9:
      holidays.add((
        holidayDate: DateTime.parse("$year-0$month-07"),
        holidayName: "07/09 - Independencia do Brasil"
      ));
    case 10:
      holidays.add((
        holidayDate: DateTime.parse("$year-$month-12"),
        holidayName: "12/10 - Nossa Senhora Aparecida"
      ));
    case 11:
      holidays.add((
        holidayDate: DateTime.parse("$year-$month-02"),
        holidayName: "02/11 - Finados"
      ));
      holidays.add((
        holidayDate: DateTime.parse("$year-$month-15"),
        holidayName: "15/11 - Proclamação da República"
      ));
    case 12:
      holidays.add((
        holidayDate: DateTime.parse("$year-$month-25"),
        holidayName: "25/12 - Natal"
      ));
    default:
  }
  return holidays;
}

List<({DateTime holidayDate, String holidayName})> listHolidaysByStateAndDate(
    int month, int year, BrazilStates state) {
  List<({DateTime holidayDate, String holidayName})> holidays = [];
  switch (state) {
    case BrazilStates.AC:
      if (month == DateTime.january) {
        holidays.addAll([
          (
            holidayDate: DateTime.parse("$year-$month-23"),
            holidayName: "23/01 - Dia do evangélico",
          ),
        ]);
      } else if (month == DateTime.june) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-15"),
          holidayName: "15/06 - Aniversário do Acre",
        ));
      } else if (month == DateTime.september) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-05"),
          holidayName: "05/09 -  Dia da Amazônia",
        ));
      } else if (month == DateTime.november) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-05"),
          holidayName: "17/11 -  Dia da Amazônia",
        ));
      }
    case BrazilStates.AL:
      if (month == DateTime.june) {
        holidays.addAll([
          (
            holidayDate: DateTime.parse("$year-$month-24"),
            holidayName: "24/06 - São João",
          ),
          (
            holidayDate: DateTime.parse("$year-$month-29"),
            holidayName: "29/06 - São Pedro",
          ),
        ]);
      } else if (month == DateTime.september) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-15"),
          holidayName: "16/09 - Emancipação política de Alagoas",
        ));
      } else if (month == DateTime.november) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-20"),
          holidayName: "20/11 -  Consciência Negra",
        ));
      }
    case BrazilStates.AM:
      if (month == DateTime.september) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-05"),
          holidayName: "05/09 - Elevação do Amazonas à categoria de província",
        ));
      } else if (month == DateTime.november) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-20"),
          holidayName: "20/11 - Consciência Negra",
        ));
      } else if (month == DateTime.december) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-08"),
          holidayName: "08/12 - Dia de Nossa Senhora da Conceição",
        ));
      }
    case BrazilStates.AP:
      if (month == DateTime.march) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-19"),
          holidayName: "19/03 - Dia de São José",
        ));
      } else if (month == DateTime.july) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-25"),
          holidayName: "25/07 - São Tiago",
        ));
      } else if (month == DateTime.october) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-05"),
          holidayName: "05/10 - Criação do estado",
        ));
      } else if (month == DateTime.november) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-20"),
          holidayName: "20/11 -  Consciência Negra",
        ));
      }
    case BrazilStates.BA:
      if (month == DateTime.july) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-02"),
          holidayName: "02/07 - Independência da Bahia",
        ));
      }
    case BrazilStates.CE:
      if (month == DateTime.march) {
        holidays.addAll([
          (
            holidayDate: DateTime.parse("$year-$month-19"),
            holidayName: "19/03 - São José",
          ),
          (
            holidayDate: DateTime.parse("$year-$month-25"),
            holidayName: "25/03 - Data Magna do Ceará",
          ),
        ]);
      }
    case BrazilStates.DF:
      if (month == DateTime.april) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-21"),
          holidayName: "21/04 - Fundação de Brasília",
        ));
      } else if (month == DateTime.november) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-30"),
          holidayName: "30/11 - Dia do Evangélico",
        ));
      }
    case BrazilStates.ES:
      if (month == DateTime.october) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-28"),
          holidayName: "28/10 - Dia do Servidor Público",
        ));
      }
    case BrazilStates.GO:
      if (month == DateTime.october) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-28"),
          holidayName: "28/10 - Dia do Servidor Público",
        ));
      }
    case BrazilStates.MA:
      if (month == DateTime.july) {
        holidays.add((
          holidayDate: DateTime.parse("$year-0$month-28"),
          holidayName: "28/07 - Adesão do Maranhão à independência do Brasil",
        ));
      } else if (month == DateTime.december) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-08"),
          holidayName: "08/12 - Dia de Nossa Senhora da Conceição",
        ));
      }
    case BrazilStates.MG:
      if (month == DateTime.april) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-21"),
          holidayName: "21/04 - Data Magna de MG"
        ));
      }
    case BrazilStates.MS:
      if (month == DateTime.december) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-11"),
          holidayName: "11/10 - Criação do estado"
        ));
      }
    case BrazilStates.MT:
      if (month == DateTime.november) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-20"),
          holidayName: "20/11 -  Consciência Negra",
        ));
      }
    case BrazilStates.PA:
      if (month == DateTime.august) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-15"),
          holidayName: "15/08 - Adesão do Grão-Pará à independência do Brasil",
        ));
      }
    case BrazilStates.PB:
      if (month == DateTime.august) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-15"),
          holidayName: "15/08 - Fundação do Estado",
        ));
      }
    case BrazilStates.PE:
      if (month == DateTime.march) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-06"),
          holidayName: "06/03 - Revolução Pernambucana (Data Magna)",
        ));
      } else if (month == DateTime.june) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-24"),
          holidayName: "24/06 - São João",
        ));
      }
    case BrazilStates.PI:
      if (month == DateTime.march) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-13"),
          holidayName: "13/03 - Dia da Batalha do Jenipapo",
        ));
      } else if (month == DateTime.october) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-19"),
          holidayName: "19/10 - Dia do Piauí",
        ));
      }
    case BrazilStates.PR:
      break;
    case BrazilStates.RJ:
      if (month == DateTime.february) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-21"),
          holidayName: "21/02 - Carnaval",
        ));
      } else if (month == DateTime.april) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-23"),
          holidayName: "23/04 - Dia de São Jorge",
        ));
      } else if (month == DateTime.october) {
        holidays.addAll([
          (
            holidayDate: DateTime.parse("$year-$month-23"),
            holidayName: "23/10 - São João",
          ),
          (
            holidayDate: DateTime.parse("$year-$month-28"),
            holidayName: "28/10 - São Pedro",
          ),
        ]);
      } else if (month == DateTime.november) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-20"),
          holidayName: "20/11 - Zumbi dos Palmares",
        ));
      }
    case BrazilStates.RN:
      if (month == DateTime.june) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-29"),
          holidayName: "29/06 - Dia de São Pedro",
        ));
      } else if (month == DateTime.october) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-03"),
          holidayName: "03/10 - Mártires de Cunhaú e Uruaçu",
        ));
      }
    case BrazilStates.RO:
      if (month == DateTime.january) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-04"),
          holidayName: "04/01 - Dia de São Pedro",
        ));
      } else if (month == DateTime.june) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-16"),
          holidayName: "16/06 - Dia do Evangélico",
        ));
      }
    case BrazilStates.RR:
      if (month == DateTime.october) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-05"),
          holidayName: "05/10 - Criação de Roraima",
        ));
      }
    case BrazilStates.RS:
      if (month == DateTime.september) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-20"),
          holidayName: "20/09 - Revolução Farroupilha",
        ));
      }
    case BrazilStates.SC:
      if (month == DateTime.august) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-11"),
          holidayName: "11/08 - Revolução Farroupilha",
        ));
      }
    case BrazilStates.SE:
      if (month == DateTime.july) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-08"),
          holidayName: "08/07 - Revolução Farroupilha",
        ));
      }
    case BrazilStates.SP:
      //TODO feriado calculado
      if (month == DateTime.april) {
        holidays.add((
          holidayDate: DateTime.parse("$year-0$month-07"),
          holidayName: "07/04 - Sexta-feira da Paixão",
        ));
      } else if (month == DateTime.july) {
        holidays.add((
          holidayDate: DateTime.parse("$year-0$month-09"),
          holidayName: "09/07 - Revolução Constitucionalista de 1932",
        ));
      }
    case BrazilStates.TO:
      if (month == DateTime.january) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-01"),
          holidayName: "01/01 - Instalação de Tocantins",
        ));
      } else if (month == DateTime.september) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-08"),
          holidayName: "08/09 - Nsa. Sra. da Natividade",
        ));
      } else if (month == DateTime.october) {
        holidays.add((
          holidayDate: DateTime.parse("$year-$month-05"),
          holidayName: "05/10 - Criação de Tocantins",
        ));
      }
  }
  return holidays;
}
