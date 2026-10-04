import 'package:flutter/material.dart';

Future<void> showPolicyPreviewModal(
  BuildContext context, {
  required String title,
  required String content,
}) async {
  await showDialog<void>(
    context: context,
    builder: (context) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820, maxHeight: 620),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Preview Document',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                const SizedBox(height: 14),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE6E8F2)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                              child: Icon(Icons.shield_outlined, size: 36)),
                          const SizedBox(height: 10),
                          Center(
                              child: Text(title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800))),
                          const SizedBox(height: 10),
                          Text(content),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
