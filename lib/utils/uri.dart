Uri getFeriadosNacionaisURI({required int year, String state = ""}) {
   const invertextoBaseUrl = "api.invertexto.com";
   const invertextoEndpoint = "v1/holidays";
    final parameters = {
      //String.fromEnvrionment only works with const https://github.com/flutter/flutter/issues/55870
      "token" : const String.fromEnvironment("TOKEN"),
    };
    if (state.isNotEmpty) {
      parameters.addAll({"state" : state});
    }
    return Uri.https(invertextoBaseUrl, "$invertextoEndpoint/$year", parameters);
}