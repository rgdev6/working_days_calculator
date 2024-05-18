import "package:get_it/get_it.dart";
import "package:http/http.dart";

import "../../utils/params.dart";
import "../../utils/uri.dart";
import "service.dart";

class HolidayServiceApi implements ServiceApi<FeriadosNacionaisParams> {
  final Client client = GetIt.I.get<Client>();

  @override
  Future<Response> getAll(FeriadosNacionaisParams params) {
    return client.get(getFeriadosNacionaisURI(params));
}
}