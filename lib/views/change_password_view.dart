import 'package:flutter/material.dart';

import '../widgets/toast_notification.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();
  bool _hideCurrent = true;
  bool _hideNext = true;
  bool _hideConfirm = true;

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 420,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_reset,
                    size: 42, color: Color(0xFF4F46E5)),
                const SizedBox(height: 10),
                const Text('Change Password',
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                const Text(
                    'Create a strong new password to secure your account.'),
                const SizedBox(height: 12),
                _passwordField('Current Password *', _current, _hideCurrent,
                    () => setState(() => _hideCurrent = !_hideCurrent)),
                const SizedBox(height: 8),
                _passwordField('New Password *', _next, _hideNext,
                    () => setState(() => _hideNext = !_hideNext)),
                const SizedBox(height: 8),
                _passwordField('Confirm Password *', _confirm, _hideConfirm,
                    () => setState(() => _hideConfirm = !_hideConfirm)),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _save,
                    child: const Text('Save Password'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordField(String label, TextEditingController ctrl, bool hidden,
      VoidCallback toggle) {
    return TextField(
      controller: ctrl,
      obscureText: hidden,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          onPressed: toggle,
          icon: Icon(hidden
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined),
        ),
      ),
    );
  }

  void _save() {
    if (_current.text.isEmpty || _next.text.isEmpty || _confirm.text.isEmpty) {
      ToastNotification.show(context,
          message: 'All fields are required', type: ToastType.error);
      return;
    }
    if (_next.text != _confirm.text) {
      ToastNotification.show(context,
          message: 'New and confirm password do not match',
          type: ToastType.error);
      return;
    }
    ToastNotification.show(context,
        message: 'Password updated successfully', type: ToastType.success);
  }
}
