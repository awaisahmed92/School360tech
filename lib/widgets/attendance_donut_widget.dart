import 'package:flutter/material.dart';

class AttendanceDonutWidget extends StatelessWidget {
  const AttendanceDonutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Attendance',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            SizedBox(height: 14),
            Center(
              child: SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: 0.92,
                      strokeWidth: 10,
                      color: Color(0xFF4F46E5),
                      backgroundColor: Color(0xFFE8EAF9),
                    ),
                    Text('92%',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _Stat(label: 'Present', value: '23'),
                _Stat(label: 'Absent', value: '2'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
        Text(label, style: const TextStyle(color: Color(0xFF6B7280))),
      ],
    );
  }
}
