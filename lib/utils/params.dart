abstract class Params {
  Map<String, dynamic> toMap();
}

class FeriadosNacionaisParams extends Params{
  final int year;
  final String state;
  final String token = const String.fromEnvironment("TOKEN");

  FeriadosNacionaisParams({required this.year, this.state = ""});

  @override
  Map<String, dynamic> toMap() {
    final params = {
      //String.fromEnvrionment only works with const https://github.com/flutter/flutter/issues/55870
      "token" : const String.fromEnvironment("TOKEN"),
    };
    if (state.isNotEmpty) {
      params.addAll({"state" : state});
    }
    return params;
  }
}