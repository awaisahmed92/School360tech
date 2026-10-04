import 'package:flutter/foundation.dart';

import 'auth_models.dart';
import 'auth_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends ChangeNotifier {
  AuthState({AuthService? service}) : _service = service ?? AuthService();

  final AuthService _service;
  AuthStatus _status = AuthStatus.unknown;
  AuthSession? _session;
  String? _error;
  bool _busy = false;

  AuthStatus get status => _status;
  AuthSession? get session => _session;
  AuthUser? get user => _session?.user;
  UserRole? get role => _session?.user.role;
  bool get busy => _busy;
  String? get error => _error;

  Future<void> bootstrap() async {
    await _service.restoreSession();
    _session = _service.session;
    _status = _session == null
        ? AuthStatus.unauthenticated
        : AuthStatus.authenticated;
    notifyListeners();
  }

  Future<bool> login({
    required String subdomain,
    required String email,
    required String password,
  }) async {
    _busy = true;
    _error = null;
    notifyListeners();
    try {
      _session = await _service.login(
        subdomain: subdomain,
        email: email,
        password: password,
      );
      _status = AuthStatus.authenticated;
      _busy = false;
      notifyListeners();
      return true;
    } on AuthException catch (e) {
      _status = AuthStatus.unauthenticated;
      _busy = false;
      _error = e.message;
      notifyListeners();
      return false;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      _busy = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _service.logout();
    _status = AuthStatus.unauthenticated;
    _session = null;
    _error = null;
    notifyListeners();
  }
}
