import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/auth/auth_state.dart';
import '../core/config/app_config.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _companyCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;
  bool _remember = false;

  @override
  void initState() {
    super.initState();
    _restoreRemembered();
  }

  Future<void> _restoreRemembered() async {
    final prefs = await SharedPreferences.getInstance();
    final remembered = prefs.getString(AppConfig.prefsRememberEmailKey);
    final company = prefs.getString(AppConfig.prefsRememberCompanyKey);
    if (!mounted || remembered == null) return;
    setState(() {
      _remember = true;
      _emailCtrl.text = remembered;
      if (company != null) _companyCtrl.text = company;
    });
  }

  @override
  void dispose() {
    _companyCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await context.read<AuthState>().login(
          companyCode: _companyCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        );
    if (!mounted) return;

    if (!ok) {
      final err = context.read<AuthState>().error ?? 'Login failed.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err), backgroundColor: Colors.red.shade700),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    if (_remember) {
      await prefs.setString(
          AppConfig.prefsRememberEmailKey, _emailCtrl.text.trim());
      await prefs.setString(
          AppConfig.prefsRememberCompanyKey, _companyCtrl.text.trim());
    } else {
      await prefs.remove(AppConfig.prefsRememberEmailKey);
      await prefs.remove(AppConfig.prefsRememberCompanyKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final busy = context.watch<AuthState>().busy;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3F5FF), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                flex: 38,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Card(
                      margin: const EdgeInsets.all(24),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(28, 28, 28, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.school,
                                    size: 30, color: Color(0xFF4F46E5)),
                                SizedBox(width: 10),
                                Text(
                                  'School360tech',
                                  style: TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1F2937)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 26),
                            const Text('Welcome Back',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            const Text('Sign in to continue',
                                style: TextStyle(
                                    color: Color(0xFF6B7280), fontSize: 15)),
                            const SizedBox(height: 24),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Company code'),
                                  const SizedBox(height: 6),
                                  TextFormField(
                                    controller: _companyCtrl,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) =>
                                        (value == null || value.trim().isEmpty)
                                            ? 'Company code is required'
                                            : null,
                                    decoration: InputDecoration(
                                      hintText: 'Same code as HR, Accounts, or POS',
                                      filled: true,
                                      fillColor: const Color(0xFFF9FAFB),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  const Text('Email'),
                                  const SizedBox(height: 6),
                                  TextFormField(
                                    controller: _emailCtrl,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) =>
                                        (value == null || value.trim().isEmpty)
                                            ? 'Email is required'
                                            : null,
                                    decoration: InputDecoration(
                                      hintText: 'you@example.com',
                                      filled: true,
                                      fillColor: const Color(0xFFF9FAFB),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  const Text('Password'),
                                  const SizedBox(height: 6),
                                  TextFormField(
                                    controller: _passwordCtrl,
                                    obscureText: _obscure,
                                    onFieldSubmitted: (_) => _submit(),
                                    validator: (value) =>
                                        (value == null || value.isEmpty)
                                            ? 'Password is required'
                                            : null,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      filled: true,
                                      fillColor: const Color(0xFFF9FAFB),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () => setState(
                                            () => _obscure = !_obscure),
                                        icon: Icon(
                                          _obscure
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    value: _remember,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: const Text('Remember me for 30 days'),
                                    onChanged: (value) => setState(
                                        () => _remember = value ?? false),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: FilledButton(
                                      style: FilledButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      onPressed: busy ? null : _submit,
                                      child: busy
                                          ? const SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: Colors.white),
                                            )
                                          : const Text('Log in'),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text('Forgot Password?'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            const Divider(),
                            const Text(
                              '© 2026 School360tech. All Rights Reserved.',
                              style: TextStyle(
                                  fontSize: 11, color: Color(0xFF6B7280)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 62,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(36, 30, 36, 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Student Management\nand Learning\nMade Simple',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 50,
                            height: 1.15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937)),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'The School360tech suite helps schools manage students,\nacademics, attendance, billing, and communication in one place.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF6B7280), fontSize: 20),
                      ),
                      const SizedBox(height: 34),
                      Container(
                        constraints:
                            const BoxConstraints(maxWidth: 520, maxHeight: 290),
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFF5F7FF), Color(0xFFECEFff)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: const Color(0xFF4F46E5).withValues(
                                alpha: 0.15,
                              )),
                        ),
                        child: const Center(
                          child: Icon(Icons.desktop_windows_outlined,
                              size: 180, color: Color(0xFF4F46E5)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
