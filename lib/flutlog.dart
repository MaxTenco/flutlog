library flutlog;

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Flutlog {
  Flutlog({
    this.tag,
  });

  final String? tag;
  final bool _enabledEmoji = true;

  void _printMessage(String message, _Color color, [_Level? level]) {
    if (kDebugMode) {
      final dateFormat = DateFormat('hh:mm:ss');
      final time = dateFormat.format(DateTime.now());

      final log = <String>[];

      log.add(time);

      if (_enabledEmoji && level != null) {
        log.add('${_getEmoji(level)} ${level.name.toUpperCase()}');
      }

      if (tag != null) {
        log.add('$tag');
      }

      log.add(message);
      print(_printWithColor(log.join(" | "), color));
    }
  }

  String _printWithColor(String text, _Color color) {
    return '\x1B[${color.value}m$text\x1B[0m';
  }

  void info(String message) {
    _printMessage(message, _Color.blu, _Level.info);
  }

  void configuration(String message) {
    _printMessage(message, _Color.magenta, _Level.configuration);
  }

  void warning(String message) {
    _printMessage(message, _Color.yellow, _Level.warning);
  }

  void debug(String message) {
    _printMessage(message, _Color.green, _Level.debug);
  }

  void error(String message) {
    _printMessage(message, _Color.red, _Level.error);
  }

  void printException(dynamic exception, [StackTrace? stackTrace]) {
    _printMessage('║ An exception occured ║ Type: ${exception.runtimeType}', _Color.red);
    _printMessage(exception.toString(), _Color.red);
    print(stackTrace);
  }

  void printEvent(FlutlogEvent event) {}

  String _getEmoji(_Level level) {
    switch (level) {
      case _Level.info:
        return '✏️';
      case _Level.debug:
        return '🐛';
      case _Level.warning:
        return '⚠️';
      case _Level.error:
        return '🚨';
      case _Level.configuration:
        return '⚙️';
    }
  }
}

enum _Color {
  red(31),
  green(32),
  yellow(33),
  blu(34),
  magenta(35);

  const _Color(this.value);

  final int value;
}

enum _Level {
  debug,
  configuration,
  info,
  warning,
  error;
}

class FlutlogEvent {}
