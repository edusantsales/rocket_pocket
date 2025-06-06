class Env {
  static const Map<String, String> _keys = <String, String>{
    'BASE_URL': String.fromEnvironment('BASE_URL'),
    'LOGIN': String.fromEnvironment('LOGIN'),
    'CATALOG': String.fromEnvironment('CATALOG'),
    'MY_CONTENT': String.fromEnvironment('MY_CONTENT'),
    'ACCOUNT': String.fromEnvironment('ACCOUNT'),
    'PROFILE': String.fromEnvironment('PROFILE'),
  };

  static String _fromJson(String key) {
    final String value = _keys[key] ?? '';
    if (value.isEmpty) {
      throw Exception('Environment variable $key is not set');
    }
    return value;
  }

  static String get baseUrl => _fromJson('BASE_URL');
  static String get login => _fromJson('LOGIN');
  static String get catalog => _fromJson('CATALOG');
  static String get myContent => _fromJson('MY_CONTENT');
  static String get account => _fromJson('ACCOUNT');
  static String get profile => _fromJson('PROFILE');
}
