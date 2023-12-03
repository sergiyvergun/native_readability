import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_readability_method_channel.dart';

abstract class NativeReadabilityPlatform extends PlatformInterface {
  /// Constructs a NativeReadabilityPlatform.
  NativeReadabilityPlatform() : super(token: _token);

  static final Object _token = Object();

  static NativeReadabilityPlatform _instance = MethodChannelNativeReadability();

  /// The default instance of [NativeReadabilityPlatform] to use.
  ///
  /// Defaults to [MethodChannelNativeReadability].
  static NativeReadabilityPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeReadabilityPlatform] when
  /// they register themselves.
  static set instance(NativeReadabilityPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<String?> parse({required String url,required String html}) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
