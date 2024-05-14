class CacheManager {
  static final CacheManager _singleton = CacheManager._internal();

  factory CacheManager() {
    return _singleton;
  }

  CacheManager._internal();

  final Map<String, Map<String, dynamic>> _cache = {};

  void store(String key, dynamic value) {
    _cache[key] = {
      'data': value,
      'timestamp': DateTime.now(),
    };
  }

  dynamic retrieve(String key) {
    return _cache[key]?['data'];
  }

  bool cachedIsFresh(String key,
      {Duration duration = const Duration(minutes: 10)}) {
    if (!_cache.containsKey(key) || !_cache[key]!.containsKey('timestamp')) {
      return false;
    }
    DateTime cachedTime = _cache[key]!['timestamp'];
    return DateTime.now().difference(cachedTime) < duration;
  }
}
