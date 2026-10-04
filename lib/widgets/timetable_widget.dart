import 'package:flutter/material.dart';

class TimetableWidget extends StatelessWidget {
  const TimetableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const slots = [
      ('Mon', 'Mathematics', '08:10 - 09:05'),
      ('Tue', 'English Language', '09:05 - 10:00'),
      ('Wed', 'Science', '11:15 - 12:05'),
      ('Thu', 'Computing', '12:05 - 12:55'),
      ('Fri', 'Urdu Literature', '12:55 - 01:35'),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Timetable',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            for (final row in slots)
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 14,
                  backgroundColor: const Color(0xFFECE9FF),
                  child: Text(row.$1.substring(0, 1),
                      style: const TextStyle(fontSize: 11)),
                ),
                title: Text(row.$2),
                subtitle: Text(row.$3),
              ),
          ],
        ),
      ),
    );
  }
}
