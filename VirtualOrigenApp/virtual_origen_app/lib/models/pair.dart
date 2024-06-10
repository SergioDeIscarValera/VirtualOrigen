class Pair<K, V> {
  final K key;
  final V value;

  Pair(this.key, this.value);

  // Pair.fromString(String string)
  //     : key = string.split(':')[0] as K,
  //       value = string.split(':')[1] as V;

  Pair.intFromString(String string)
      : key = int.parse(string.split(':')[0]) as K,
        value = int.parse(string.split(':')[1]) as V;

  Pair.doubleFromString(String string)
      : key = double.parse(string.split(':')[0]) as K,
        value = double.parse(string.split(':')[1]) as V;
  @override
  String toString() {
    return '$key:$value';
  }
}
