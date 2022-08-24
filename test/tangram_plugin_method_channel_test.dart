import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tangram_plugin/tangram_plugin_method_channel.dart';

void main() {
  MethodChannelTangramPlugin platform = MethodChannelTangramPlugin();
  const MethodChannel channel = MethodChannel('tangram_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
