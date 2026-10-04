// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

const _vaultKey = 'school360_session_v1';

void writeSessionVault(String raw) {
  html.window.localStorage[_vaultKey] = raw;
}

String? readSessionVault() => html.window.localStorage[_vaultKey];

void clearSessionVault() {
  html.window.localStorage.remove(_vaultKey);
}
