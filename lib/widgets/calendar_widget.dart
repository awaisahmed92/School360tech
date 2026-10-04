import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Calendar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 35,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (_, i) {
                final day = i - 2;
                final active = day > 0 && day <= 31;
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: day == 12
                        ? const Color(0xFF4F46E5)
                        : const Color(0xFFF6F7FD),
                  ),
                  child: Center(
                    child: Text(
                      active ? '$day' : '',
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            day == 12 ? Colors.white : const Color(0xFF374151),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
