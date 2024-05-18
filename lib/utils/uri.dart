import "params.dart";

Uri getFeriadosNacionaisURI(FeriadosNacionaisParams params) {
   const invertextoBaseUrl = "api.invertexto.com";
   const invertextoEndpoint = "v1/holidays";
   return Uri.https(invertextoBaseUrl, "$invertextoEndpoint/${params.year}", params.toMap());
}