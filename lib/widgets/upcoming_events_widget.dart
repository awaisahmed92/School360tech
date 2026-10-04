import 'package:flutter/material.dart';

class UpcomingEventsWidget extends StatelessWidget {
  const UpcomingEventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Upcoming Events',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            _event('05 Oct', 'Parent Teacher Meeting'),
            _event('11 Oct', 'Science Fair Exhibition'),
            _event('24 Oct', 'Sports Day Practice'),
          ],
        ),
      ),
    );
  }

  Widget _event(String date, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 56,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFECE9FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              date,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(title)),
        ],
      ),
    );
  }
}
