class ServerException implements Exception {
  final String message = 'Server Exception';
}

class EmptyCacheException implements Exception {
  final String message = 'Empty Cache Exception';
}

class OfflineException implements Exception {
  final String message = 'Offline Exception';
}
