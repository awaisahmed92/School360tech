import 'package:flutter/material.dart';

class CourseCardWidget extends StatelessWidget {
  const CourseCardWidget({
    super.key,
    required this.name,
    required this.programName,
    required this.instructor,
    required this.charges,
    required this.duration,
    this.onTap,
  });

  final String name;
  final String programName;
  final String instructor;
  final String charges;
  final String duration;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE9FE),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text('Enroll',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                ),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.sports_kabaddi,
                  size: 34, color: Color(0xFF4F46E5)),
              const SizedBox(height: 10),
              Text(name, style: const TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text('Program Name: $programName',
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
              const SizedBox(height: 6),
              Text('Instructor: $instructor',
                  style: const TextStyle(fontSize: 12)),
              Text('Charges: $charges', style: const TextStyle(fontSize: 12)),
              Text('Duration: $duration', style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
