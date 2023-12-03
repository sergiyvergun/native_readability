import 'package:flutter_test/flutter_test.dart';
import 'package:native_readability/native_readability.dart';
import 'package:native_readability/native_readability_platform_interface.dart';
import 'package:native_readability/native_readability_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNativeReadabilityPlatform
    with MockPlatformInterfaceMixin
    implements NativeReadabilityPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NativeReadabilityPlatform initialPlatform = NativeReadabilityPlatform.instance;

  test('$MethodChannelNativeReadability is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNativeReadability>());
  });

  test('getPlatformVersion', () async {
    NativeReadability nativeReadabilityPlugin = NativeReadability();
    MockNativeReadabilityPlatform fakePlatform = MockNativeReadabilityPlatform();
    NativeReadabilityPlatform.instance = fakePlatform;

    expect(await nativeReadabilityPlugin.getPlatformVersion(), '42');
  });
}
