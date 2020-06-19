import 'dart:async';

import 'package:flutter/services.dart';

/// FlutterUtils 工具类
class FlutterUtils {
  static const MethodChannel _channel = const MethodChannel('flutter_utils_z');

  /// 返回路径前缀，带最后的 `/`
  ///
  static Future<String> test() async {
    final String result = await _channel.invokeMethod('getPlatformVersion');
    return result;
  }

  /// 返回路径前缀，带最后的 `/`
  ///
  static Future<String> getAssetPathPrefix(String existedPath) async {
    final String path = await _channel.invokeMethod('getAssetPathPrefix', {'existedPath': existedPath});
    return path;
  }

  /// 返回具体的路径, 可以对比 [getAssetPathPrefix]
  ///
  static Future<String> getAssetPath(String assetPath) async {
    final String path = await _channel.invokeMethod('getAssetPath', {'path': assetPath});
    return path;
  }
}
