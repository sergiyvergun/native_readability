package com.example.native_readability

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import net.dankito.readability4j.Article
import net.dankito.readability4j.Readability4J
import net.dankito.readability4j.extended.Readability4JExtended

/** NativeReadabilityPlugin */
class NativeReadabilityPlugin : FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "native_readability")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) { // Fix this line
    if (call.method == "parse") {
      val url = call.argument<String>("url")!!
      val html = call.argument<String>("html")!!
      try {
        val parsedHTML = parse(url, html)
        result.success(parsedHTML)
      } catch (e: Exception) {
        result.error("PARSE_ERROR", "Error parsing html: ${e.message}", null)
      }

    } else {
      result.notImplemented()
    }
  }

  fun parse(url: String, html: String): String? {
    val readability4J: Readability4J = Readability4JExtended(url, html)
    val article: Article = readability4J.parse()
    return article.contentWithDocumentsCharsetOrUtf8
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
