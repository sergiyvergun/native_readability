import 'native_readability_platform_interface.dart';

class NativeReadability {
  Future<String?> getPlatformVersion() {
    return NativeReadabilityPlatform.instance.getPlatformVersion();
  }

  Future<String?> parse({required String url, required String html}) {
    return NativeReadabilityPlatform.instance.parse(url: url, html: html);
  }
}
