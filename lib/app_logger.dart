import 'package:flutter/foundation.dart';

/// Log levels for filtering and categorizing log messages.
enum LogLevel {
  /// Debug-level messages for detailed diagnostic information.
  debug,

  /// Informational messages about normal application flow.
  info,

  /// Warning messages for potentially problematic situations.
  warning,

  /// Error messages for error conditions that don't stop execution.
  error,

  /// Critical error messages for severe issues that may stop execution.
  critical,
}

/// A centralized logging service for the application.
///
/// Provides structured logging with different log levels and optional
/// filtering capabilities. Uses Flutter's [debugPrint] for output.
///
/// Example usage:
/// ```dart
/// AppLogger.instance.info('Application started');
/// AppLogger.instance.error('Failed to load data', error: e);
/// AppLogger.instance.debug('Processing item', data: {'id': 123});
/// ```
class AppLogger {
  /// Singleton instance of the logger.
  static final AppLogger instance = AppLogger._internal();

  /// Minimum log level to output. Messages below this level are filtered out.
  LogLevel _minLevel = LogLevel.debug;

  /// Whether to include timestamps in log messages.
  bool includeTimestamp = true;

  /// Whether to include the log level prefix in messages.
  bool includeLevelPrefix = true;

  /// Custom prefix to add to all log messages.
  String? customPrefix;

  AppLogger._internal();

  /// Sets the minimum log level. Messages below this level will be filtered.
  ///
  /// Example:
  /// ```dart
  /// AppLogger.instance.setMinLevel(LogLevel.warning);
  /// // Only warning, error, and critical messages will be logged
  /// ```
  void setMinLevel(LogLevel level) {
    _minLevel = level;
  }

  /// Gets the current minimum log level.
  LogLevel get minLevel => _minLevel;

  /// Logs a debug-level message.
  ///
  /// Use for detailed diagnostic information that is typically only
  /// interesting during development.
  void debug(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    _log(
      LogLevel.debug,
      message,
      error: error,
      stackTrace: stackTrace,
      data: data,
    );
  }

  /// Logs an informational message.
  ///
  /// Use for general informational messages about normal application flow.
  void info(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    _log(
      LogLevel.info,
      message,
      error: error,
      stackTrace: stackTrace,
      data: data,
    );
  }

  /// Logs a warning message.
  ///
  /// Use for potentially problematic situations that don't prevent
  /// the application from functioning.
  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    _log(
      LogLevel.warning,
      message,
      error: error,
      stackTrace: stackTrace,
      data: data,
    );
  }

  /// Logs an error message.
  ///
  /// Use for error conditions that don't stop execution but should
  /// be investigated.
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    _log(
      LogLevel.error,
      message,
      error: error,
      stackTrace: stackTrace,
      data: data,
    );
  }

  /// Logs a critical error message.
  ///
  /// Use for severe issues that may stop execution or require
  /// immediate attention.
  void critical(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    _log(
      LogLevel.critical,
      message,
      error: error,
      stackTrace: stackTrace,
      data: data,
    );
  }

  /// Internal method to handle logging logic.
  void _log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    // Filter out messages below the minimum level
    if (_shouldLog(level)) {
      final buffer = StringBuffer();

      // Add custom prefix if set
      if (customPrefix != null) {
        buffer.write('[$customPrefix] ');
      }

      // Add timestamp if enabled
      if (includeTimestamp) {
        final now = DateTime.now();
        buffer.write('[${now.toIso8601String()}] ');
      }

      // Add level prefix if enabled
      if (includeLevelPrefix) {
        buffer.write('[${level.name.toUpperCase()}] ');
      }

      // Add the main message
      buffer.write(message);

      // Add error information if provided
      if (error != null) {
        buffer.write('\nError: $error');
      }

      // Add stack trace if provided
      if (stackTrace != null) {
        buffer.write('\nStackTrace:\n$stackTrace');
      }

      // Add additional data if provided
      if (data != null && data.isNotEmpty) {
        buffer.write('\nData: $data');
      }

      // Output using Flutter's debugPrint
      debugPrint(buffer.toString());

      // In release mode, you might want to send critical errors to a crash reporting service
      if (kReleaseMode && level == LogLevel.critical && error != null) {
        // TODO: Integrate with crash reporting service (e.g., Sentry, Firebase Crashlytics)
      }
    }
  }

  /// Checks if a message with the given level should be logged.
  bool _shouldLog(LogLevel level) {
    return level.index >= _minLevel.index;
  }

  /// Resets the logger configuration to defaults.
  void reset() {
    _minLevel = LogLevel.debug;
    includeTimestamp = true;
    includeLevelPrefix = true;
    customPrefix = null;
  }
}
