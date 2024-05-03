import "package:get_it/get_it.dart";
import "package:http/http.dart";

import "../../utils/uri.dart";

class HolidayServiceApi {
  final Client client = GetIt.I.get<Client>();

  Future<Response> getHolidays({required int year, String state = ""}) {
    return client.get(getFeriadosNacionaisURI(year: year, state: state));
}
}