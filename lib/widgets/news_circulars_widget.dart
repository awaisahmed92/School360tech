import 'package:flutter/material.dart';

class NewsCircularsWidget extends StatelessWidget {
  const NewsCircularsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      ('CIRCULAR', 'Annual Day rehearsal schedule has been updated'),
      ('NEWS', 'Spark Program registrations are now open'),
      ('NEWS', 'Term 1 PTM slots published for all classes'),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('News & Circulars',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            for (final item in items)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE6E8F3)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEAFE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(item.$1,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(item.$2)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
