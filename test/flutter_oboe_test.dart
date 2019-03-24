import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_oboe/flutter_oboe.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_oboe');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await flutter_oboe.platformVersion, '42');
  });
}
