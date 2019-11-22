import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/services.dart';

class FlutterUtils {
  static const MethodChannel _channel = const MethodChannel('flutter_utils_z');

  /// 返回路径前缀，带最后的 `/`
  static Future<String> getAssetPathPrefix(String existedPath) async {
    assert(Platform.isIOS, 'Android版本未实现');
    final String path = await _channel
        .invokeMethod('getAssetPathPrefix', {'existedPath': existedPath});
    return path;
  }

  /// 返回具体的路径
  static Future<String> getAssetPath(String assetPath) async {
    assert(Platform.isIOS, 'Android版本未实现');
    final String path =
        await _channel.invokeMethod('getAssetPath', {'path': assetPath});
    return path;
  }
}
