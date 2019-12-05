import 'dart:async';

void _print(message) {
//  print('Throttle debug: $message');
}

//DateTime _lastDateTime;
//
//enum ThrottleAction {
//  cancel,
//  operate,
//}
//
///// 自己实现的，只能满足没有参数的情况，并且只允许一个block(加Map存储可满足多个).
//throttle(callback, {Duration duration = const Duration(milliseconds: 200), ThrottleAction action = ThrottleAction.cancel}) {
//  _print('callback.hash = ${callback.hashCode}');
//  if (_lastDateTime == null) {
//    _lastDateTime = DateTime.now();
//    callback();
//  } else {
//    int dis = duration.inMilliseconds;
//
//    /// 超过了延迟，需要执行一次
//    if (DateTime.now().millisecondsSinceEpoch < _lastDateTime.millisecondsSinceEpoch + dis) {
//      if (action == ThrottleAction.cancel) {
//        _print('ignore action');
//      } else {
//        // TODO:
//      }
//    } else {
//      _lastDateTime = DateTime.now();
//      callback();
//    }
//  }
//}

Map<Function, _ActionTarget> _throttled = <Function, _ActionTarget>{};
Map<Function, Timer> _debounced = <Function, Timer>{};

/// 注意：这里需要确保 `target` 保持不变。临时变量和直接写的 `(){...}` 都不行。
class Throttle {
  static bool seconds(int timeoutSeconds, Function target, [List<dynamic> positionalArguments, Map<Symbol, dynamic> namedArguments]) =>
      duration(Duration(seconds: timeoutSeconds), target, positionalArguments, namedArguments);

  static bool duration(Duration timeout, Function target, [List<dynamic> positionalArguments, Map<Symbol, dynamic> namedArguments]) {
    if (_throttled.containsKey(target)) {
      return false;
    }

    _print('positionalArguments = $positionalArguments');
    _print('namedArguments = $namedArguments');

    try {
      Function.apply(target, positionalArguments, namedArguments);
    } catch (e) {
      assert(false, 'Throttle error: $e');
    }

    final _ActionTarget throttleTarget = _ActionTarget(target, positionalArguments, namedArguments);
    _throttled[target] = throttleTarget;
    Timer(timeout, () {
      _throttled.remove(target);
    });

    return true;
  }

  static bool clear(Function target) {
    if (_throttled.containsKey(target)) {
      _throttled.remove(target);
      return true;
    }

    return false;
  }
}

/// 注意：这里需要确保 `target` 保持不变。临时变量和直接写的 `(){...}` 都不行。
class DeBouncer {
  static bool seconds(int timeoutSeconds, Function target, [List<dynamic> positionalArguments, Map<Symbol, dynamic> namedArguments]) =>
      duration(Duration(seconds: timeoutSeconds), target, positionalArguments, namedArguments);

  static bool duration(Duration timeout, Function target, [List<dynamic> positionalArguments, Map<Symbol, dynamic> namedArguments]) {
    if (_debounced.containsKey(target)) {
      Timer timer = _debounced[target];
      timer.cancel();
      _debounced.remove(target);
    }

    _print('positionalArguments = $positionalArguments');
    _print('namedArguments = $namedArguments');

    Timer actionTimer = Timer(timeout, () {
      try {
        Function.apply(target, positionalArguments, namedArguments);
      } catch (e) {
        assert(false, 'DeBouncer error: $e');
      }
    });
    _debounced[target] = actionTimer;

    return true;
  }

  static bool clear(Function target) {
    if (_debounced.containsKey(target)) {
      Timer timer = _debounced[target];
      timer.cancel();
      _debounced.remove(target);
      return true;
    }

    return false;
  }
}

// _ThrottleTimer allows us to keep track of the target function
// along with it's timer.
class _ActionTarget {
  final Function target;
  final List<dynamic> positionalArguments;
  final Map<Symbol, dynamic> namedArguments;

  _ActionTarget(this.target, this.positionalArguments, this.namedArguments);
}
