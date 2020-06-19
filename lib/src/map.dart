/// force to convert Map from Map<dynamic, dynamic> to Map<String, String>
Map<String, String> forceConvertMap(Map<dynamic, dynamic> a) {
  if (a is Map) {
    try {
      Map<String, String> b = Map.from(a);
      return b;
    } catch (e) {
      Map<String, String> c = {};
      a.keys.forEach((curKey) {
        c.putIfAbsent('$curKey', () => '${a[curKey]}');
      });
      return c;
    }
  }

  return Map<String, String>();
}
