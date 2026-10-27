import 'package:flutter/material.dart';

/// Public school website. The login app stays on a company address.
class ProductIntroView extends StatelessWidget {
  const ProductIntroView({
    super.key,
    required this.onTryNow,
    required this.onSignIn,
  });

  final VoidCallback onTryNow;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07111F),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.7, -0.8),
            radius: 1.3,
            colors: [Color(0xFF1E3A8A), Color(0xFF0B1730), Color(0xFF07111F)],
            stops: [0, 0.5, 1],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 900;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: wide ? 40 : 20, vertical: 18),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Bar(onTryNow: onTryNow, onSignIn: onSignIn),
                        SizedBox(height: wide ? 72 : 40),
                        Text(
                          'SCHOOL CLOUD',
                          style: TextStyle(
                            color: const Color(0xFF93C5FD),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Admissions, fees, and\nthe classroom in one place.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: wide ? 52 : 36,
                            height: 1.05,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 18),
                        const SizedBox(
                          width: 620,
                          child: Text(
                            'Run the school from one workspace: students, parents, staff, attendance, fees, and the timetable stay with the same company.',
                            style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 18, height: 1.5),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _Cta(label: 'Get started', filled: true, onPressed: onTryNow),
                            _Cta(label: 'Sign in', filled: false, onPressed: onSignIn),
                          ],
                        ),
                        const SizedBox(height: 48),
                        const Wrap(
                          spacing: 14,
                          runSpacing: 14,
                          children: [
                            _Feature(step: '1', title: 'Students', body: 'Admissions, classes, and parent records stay with the school.'),
                            _Feature(step: '2', title: 'Classroom', body: 'Timetable, attendance, and learning stay on the same roll.'),
                            _Feature(step: '3', title: 'Fees', body: 'Billing and receipts stay with the student, not a second spreadsheet.'),
                            _Feature(step: '4', title: 'Company', body: 'A new school is the same client record HR and Accounts already use.'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.onTryNow, required this.onSignIn});

  final VoidCallback onTryNow;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: const Color(0xFF1D4ED8), borderRadius: BorderRadius.circular(10)),
          child: const Text('S', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
        ),
        const SizedBox(width: 10),
        const Text('School360tech', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
        const Spacer(),
        TextButton(onPressed: onSignIn, child: const Text('Sign in')),
        const SizedBox(width: 8),
        FilledButton(onPressed: onTryNow, child: const Text('Get started')),
      ],
    );
  }
}

class _Cta extends StatelessWidget {
  const _Cta({required this.label, required this.filled, required this.onPressed});

  final String label;
  final bool filled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (filled) {
      return FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        ),
        child: Text(label),
      );
    }
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFF64748B)),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      ),
      child: Text(label),
    );
  }
}

class _Feature extends StatelessWidget {
  const _Feature({required this.step, required this.title, required this.body});

  final String step;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(step, style: const TextStyle(color: Color(0xFF93C5FD), fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(body, style: const TextStyle(color: Color(0xFFCBD5E1), height: 1.4)),
        ],
      ),
    );
  }
}
