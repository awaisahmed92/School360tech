import 'package:flutter/foundation.dart';

class AppConfig {
  AppConfig._();

  static const _defineApi = String.fromEnvironment('API_BASE_URL');
  static const _prodDefaultApi = String.fromEnvironment(
    'PROD_API_BASE_URL',
    defaultValue: 'https://school360tech.com/api',
  );
  static const _localApi = 'http://localhost/360tech/School360tech/backend/api';

  static String get apiBaseUrl {
    if (_defineApi.trim().isNotEmpty) return _normalize(_defineApi);
    if (kIsWeb) {
      final base = Uri.base;
      final host = base.host.toLowerCase();
      final loopback = host == 'localhost' || host == '127.0.0.1';
      if (loopback && base.port != 80 && base.port != 443) return _localApi;
      return _normalize('${base.origin}/api');
    }
    if (kReleaseMode) return _normalize(_prodDefaultApi);
    return _normalize(_localApi);
  }

  static String _normalize(String value) {
    var v = value.trim();
    while (v.endsWith('/')) {
      v = v.substring(0, v.length - 1);
    }
    return v;
  }

  static const prefsTokenKey = 'school360_token';
  static const prefsSessionKey = 'school360_session_json';
  static const prefsRememberEmailKey = 'school360_login_email';
}
