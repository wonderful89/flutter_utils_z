bool isValid(dynamic a) {
  if (a == null) {
    return false;
  }

  if (a is String) {
    return a.isNotEmpty;
  } else if (a is List) {
    return a.length > 0;
  }

  return true;
}
