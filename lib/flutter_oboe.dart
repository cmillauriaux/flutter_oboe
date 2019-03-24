import 'dart:async';

import 'package:flutter/services.dart';

class flutter_oboe {
  static const MethodChannel _channel =
      const MethodChannel('flutter_oboe');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void playTone() async {
    await _channel.invokeMethod('playTone');
  }

  static void stopTone() async {
    await _channel.invokeMethod('stopTone');
  }
}
