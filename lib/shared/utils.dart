import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

abstract final class Utils {
  Utils._();

  static void log({
    required String message,
    Level level = Level.info,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      final logger = Logger();
      logger.log(level, message, error: error, stackTrace: stackTrace);
      logger.close();
    }
  }
}
