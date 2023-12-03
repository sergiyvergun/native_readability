import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_readability_platform_interface.dart';

/// An implementation of [NativeReadabilityPlatform] that uses method channels.
class MethodChannelNativeReadability extends NativeReadabilityPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('native_readability');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> parse({required String url, required String html}) async {
    final version = await methodChannel.invokeMethod<String>(
        'parse', <String, dynamic>{'url': url, 'html': html});
    return version;
  }
}
