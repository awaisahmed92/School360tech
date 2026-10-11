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

  InputDecoration _field(String hint, {Widget? suffix, IconData? icon}) {
    const radius = BorderRadius.all(Radius.circular(10));
    const side = BorderSide(color: Color(0xFFD9D6F5));
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      prefixIcon: icon == null ? null : Icon(icon, size: 18, color: Color(0xFF64748B)),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      border: const OutlineInputBorder(borderRadius: radius, borderSide: side),
      enabledBorder: const OutlineInputBorder(borderRadius: radius, borderSide: side),
      focusedBorder: const OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Color(0xFF4338CA), width: 1.6),
      ),
    );
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
    final wide = MediaQuery.sizeOf(context).width >= 980;
    final form = _form(busy);
    return Scaffold(
      backgroundColor: const Color(0xFFE8E7F4),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(wide ? 18 : 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(wide ? 28 : 0),
            child: ColoredBox(
              color: Colors.white,
              child: wide
                  ? Row(children: [Expanded(flex: 5, child: form), const Expanded(flex: 6, child: _SchoolStory())])
                  : form,
            ),
          ),
        ),
      ),
    );
  }

  Widget _form(bool busy) {
    return LayoutBuilder(
            builder: (context, constraints) {
              final form = Center(
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
                          mainAxisSize: MainAxisSize.min,
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
                                    decoration: _field('Same code as HR, Accounts, or POS', icon: Icons.apartment_outlined),
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
                                    decoration: _field('you@example.com', icon: Icons.mail_outline),
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
                                    decoration: _field(
                                      'Enter your password',
                                      icon: Icons.lock_outline,
                                      suffix: IconButton(
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
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _remember,
                                        activeColor: const Color(0xFF4F46E5),
                                        onChanged: (value) => setState(
                                            () => _remember = value ?? false),
                                      ),
                                      const Text('Remember me for 30 days'),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: FilledButton(
                                      style: FilledButton.styleFrom(
                                        backgroundColor: const Color(0xFF312E81),
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
                            const SizedBox(height: 24),
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
                );
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: form,
                ),
              );
            },
    );
  }
}

class _SchoolStory extends StatefulWidget {
  const _SchoolStory();

  @override
  State<_SchoolStory> createState() => _SchoolStoryState();
}

class _SchoolStoryState extends State<_SchoolStory> with SingleTickerProviderStateMixin {
  late final AnimationController _float = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);

  @override
  void dispose() {
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF1E1B4B), Color(0xFF4338CA)], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: AnimatedBuilder(
        animation: _float,
        builder: (context, _) {
          final dy = (_float.value - 0.5) * 16;
          return Stack(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(48, 56, 48, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SCHOOL360TECH', style: TextStyle(color: Color(0xFFC7D2FE), fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                    SizedBox(height: 18),
                    Text('A calmer desk\nfor the whole school', style: TextStyle(color: Colors.white, fontSize: 40, height: 1.12, fontWeight: FontWeight.w700)),
                    SizedBox(height: 22),
                    Text('“Admissions, attendance, and fees stopped living in five different books.”', style: TextStyle(color: Color(0xFFE0E7FF), fontSize: 18, height: 1.45)),
                    SizedBox(height: 18),
                    Text('Sara Qureshi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    Text('Registrar, city campus', style: TextStyle(color: Color(0xFFC7D2FE))),
                  ],
                ),
              ),
              Positioned(top: 40 + dy, right: 28, child: const _FloatNote(icon: Icons.school_outlined, title: 'Today', subtitle: '96% attendance')),
              Positioned(bottom: 40 - dy, right: 46, child: const _FloatNote(icon: Icons.menu_book_outlined, title: 'Term', subtitle: 'Fees posted')),
            ],
          );
        },
      ),
    );
  }
}

class _FloatNote extends StatelessWidget {
  const _FloatNote({required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 18, offset: Offset(0, 8))],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF312E81)),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ])),
        ],
      ),
    );
  }
}
