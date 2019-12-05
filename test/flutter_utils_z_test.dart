import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_utils_z/flow_control.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_utils_z');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('throttle', () async {
    var checkStr = 'empty';

    void printSeconds(str, {String str2}) {
      checkStr = str;
      print("Hello World (Throttle.seconds:) $str == $str2");
    }

    Throttle.seconds(1, printSeconds, ['aaa'], {Symbol('str2'): 'str22'});
    expect(checkStr, equals('aaa'));

    /// 不会执行
    Throttle.seconds(1, printSeconds, ['ddd'], {Symbol('str2'): 'str22'});
    expect(checkStr, isNot('ddd'));

    Future.delayed(Duration(seconds: 2), () {
      Throttle.seconds(5, printSeconds, ['bbb'], {Symbol('str2'): 'str22'});
      expect(checkStr, 'bbb');
    });

    /// 不会执行
    Future.delayed(Duration(seconds: 4), () {
      Throttle.seconds(1, printSeconds, ['ccc'], {Symbol('str2'): 'str22'});
      expect(checkStr, isNot('ccc'));
    });

    await Future.delayed(Duration(seconds: 10));
  });

  test('debounce-正常执行', () async {
    var checkStr = 'empty';

    void printSeconds(str) {
      checkStr = str;
      print("Hello World (Throttle.seconds:) $str");
    }

    DeBouncer.seconds(1, printSeconds, ['aaa']);
    expect(checkStr, isNot('aaa'));

    DeBouncer.seconds(1, printSeconds, ['aaa']);
    expect(checkStr, isNot('ccc'));

    DeBouncer.seconds(1, printSeconds, ['ddd']);
    expect(checkStr, isNot('ddd'));

    await Future.delayed(Duration(seconds: 2));
    expect(checkStr, ('ddd'));

    await Future.delayed(Duration(seconds: 5));
  });

  test('debounce-取消操作', () async {
    var checkStr = 'empty';

    void printSeconds(str) {
      checkStr = str;
      print("Hello World (Throttle.seconds:) $str");
    }

    DeBouncer.seconds(1, printSeconds, ['aaa']);
    expect(checkStr, isNot('aaa'));

    DeBouncer.seconds(1, printSeconds, ['ddd']);
    expect(checkStr, isNot('ddd'));

    DeBouncer.clear(printSeconds);

    await Future.delayed(Duration(seconds: 2));
    expect(checkStr, 'empty');
  });
}
