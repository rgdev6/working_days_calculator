class StarDateAfterException implements Exception {
  final String cause;

  StarDateAfterException(this.cause);

  @override
  String toString() {
    return "StarDateAfterException: $cause";
  }
}