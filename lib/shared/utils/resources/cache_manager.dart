class CacheManager {
  static final CacheManager _singleton = CacheManager._internal();

  factory CacheManager() {
    return _singleton;
  }

  CacheManager._internal();

  final Map<String, dynamic> _cache = {};

  void store(String key, dynamic value) {
    _cache[key] = value;
  }

  dynamic retrieve(String key) {
    return _cache[key];
  }
}
