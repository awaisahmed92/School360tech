import 'package:flutter/material.dart';

enum ToastType { success, error, info }

class ToastNotification {
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
  }) {
    final color = switch (type) {
      ToastType.success => const Color(0xFF16A34A),
      ToastType.error => const Color(0xFFDC2626),
      ToastType.info => const Color(0xFF2563EB),
    };

    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        content: Row(
          children: [
            Icon(
              type == ToastType.error
                  ? Icons.error_outline
                  : Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
}
