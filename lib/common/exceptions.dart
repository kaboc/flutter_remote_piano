class GenericException implements Exception {
  @override
  String toString() => runtimeType.toString();
}

class PlatformUnsupportedException = GenericException with Type;
class ConnectionFailureException = GenericException with Type;
