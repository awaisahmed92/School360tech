import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';
import '../network/dio_client.dart';
import 'auth_models.dart';
import 'session_vault.dart';

class AuthException implements Exception {
  AuthException(this.message);
  final String message;
}

class AuthService {
  AuthService({DioClient? client}) : _client = client ?? DioClient();

  final DioClient _client;
  AuthSession? _session;

  AuthSession? get session => _session;

  Future<void> restoreSession() async {
    _hydrateFromRaw(readSessionVault());
    if (_session != null) return;

    final prefs = await SharedPreferences.getInstance();
    _hydrateFromRaw(prefs.getString(AppConfig.prefsSessionKey));
  }

  Future<AuthSession> login({
    required String subdomain,
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty || password.isEmpty) {
      throw AuthException('Email and password are required.');
    }
    try {
      final response = await _client.dio.post(
        '/login.php',
        data: {
          'subdomain': subdomain.trim().toLowerCase(),
          'email': email.trim(),
          'password': password,
        },
      );
      final body = response.data;
      if (body is! Map || body['success'] != true) {
        throw AuthException(
            (body is Map ? body['message'] : null)?.toString() ??
                'Login failed.');
      }
      final session =
          AuthSession.fromJson(Map<String, dynamic>.from(body['data'] as Map));
      await _persist(session);
      return session;
    } on DioException catch (e) {
      final body = e.response?.data;
      if (body is Map && body['message'] != null) {
        throw AuthException(body['message'].toString());
      }
      throw AuthException(
          'Unable to reach School360tech API at ${AppConfig.apiBaseUrl}.');
    }
  }

  Future<void> logout() async {
    _session = null;
    clearSessionVault();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConfig.prefsSessionKey);
    await prefs.remove(AppConfig.prefsTokenKey);
  }

  void _hydrateFromRaw(String? raw) {
    if (raw == null || raw.isEmpty) return;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        _session = AuthSession.fromJson(decoded);
      } else if (decoded is Map) {
        _session = AuthSession.fromJson(Map<String, dynamic>.from(decoded));
      }
    } catch (_) {
      _session = null;
    }
  }

  Future<void> _persist(AuthSession session) async {
    _session = session;
    final raw = jsonEncode(session.toJson());
    writeSessionVault(raw);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConfig.prefsSessionKey, raw);
    await prefs.setString(AppConfig.prefsTokenKey, session.token);
  }
}
