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
    if (!mounted || remembered == null) return;
    setState(() {
      _remember = true;
      _emailCtrl.text = remembered;
    });
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await context.read<AuthState>().login(
          subdomain: Uri.base.host.split('.').first,
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
    } else {
      await prefs.remove(AppConfig.prefsRememberEmailKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final busy = context.watch<AuthState>().busy;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 35,
            child: Container(
              color: const Color(0xFFF8F9FF),
              padding: const EdgeInsets.fromLTRB(16, 44, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.school, size: 34, color: Color(0xFF4F46E5)),
                      SizedBox(width: 10),
                      Text(
                        'School360tech',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  const Text('Login',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                  const Text('Sign in to continue'),
                  const SizedBox(height: 22),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Email'),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              (value == null || value.trim().isEmpty)
                                  ? 'Email is required'
                                  : null,
                        ),
                        const SizedBox(height: 12),
                        const Text('Password'),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _passwordCtrl,
                          obscureText: _obscure,
                          onFieldSubmitted: (_) => _submit(),
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'Password is required'
                              : null,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          value: _remember,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text('Remember me for 30 days'),
                          onChanged: (value) =>
                              setState(() => _remember = value ?? false),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: busy ? null : _submit,
                            child: busy
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: Colors.white),
                                  )
                                : const Text('Log in'),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password?'),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text('Download our mobile app for a better experience'),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      _StoreBadge(text: 'Get it on\nGoogle Play'),
                      SizedBox(width: 8),
                      _StoreBadge(text: 'Download on the\nApp Store'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '© 2026 School360tech. All Rights Reserved.',
                    style: TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 65,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.waves_rounded,
                          size: 72, color: Color(0xFFF4C542)),
                      Icon(Icons.grid_3x3_rounded,
                          size: 44, color: Color(0xFF6B63F2)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Student Management\n+\nLearning Management Made Simple.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'The School360tech suite makes school operations & learning simple for all stakeholders.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF6B7280), fontSize: 20),
                  ),
                  const SizedBox(height: 28),
                  Expanded(
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 430),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F7FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Icon(Icons.desktop_mac_outlined,
                              size: 170, color: Color(0xFF4F46E5)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoreBadge extends StatelessWidget {
  const _StoreBadge({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 11, height: 1.15),
      ),
    );
  }
}
