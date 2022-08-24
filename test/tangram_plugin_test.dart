import 'package:flutter_test/flutter_test.dart';
import 'package:tangram_plugin/tangram_plugin.dart';
import 'package:tangram_plugin/tangram_plugin_platform_interface.dart';
import 'package:tangram_plugin/tangram_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTangramPluginPlatform 
    with MockPlatformInterfaceMixin
    implements TangramPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TangramPluginPlatform initialPlatform = TangramPluginPlatform.instance;

  test('$MethodChannelTangramPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTangramPlugin>());
  });

  test('getPlatformVersion', () async {
    TangramPlugin tangramPlugin = TangramPlugin();
    MockTangramPluginPlatform fakePlatform = MockTangramPluginPlatform();
    TangramPluginPlatform.instance = fakePlatform;
  
    expect(await tangramPlugin.getPlatformVersion(), '42');
  });
}
