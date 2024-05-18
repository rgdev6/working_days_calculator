import "package:http/http.dart";

import "../../utils/params.dart";

abstract class ServiceApi<P extends Params>{
  Future<Response> getAll(P params);
}