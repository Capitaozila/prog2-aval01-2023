class InvalidDataFormatException implements Exception {
  final String message;

  InvalidDataFormatException(this.message);

  @override
  String toString() => 'InvalidDataFormatException: $message';
}
