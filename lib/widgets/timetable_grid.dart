import 'package:flutter/material.dart';

class TimetableGrid extends StatelessWidget {
  const TimetableGrid({
    super.key,
    required this.days,
  });

  final List<TimetableDay> days;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final day in days)
            Container(
              width: 230,
              margin: const EdgeInsets.only(right: 12),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(day.name,
                          style: const TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      for (final slot in day.slots)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: slot.type == SlotType.period
                                ? const Color(0xFFF8F9FF)
                                : const Color(0xFFFFF4F1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border(
                              left: BorderSide(
                                color: slot.type == SlotType.period
                                    ? const Color(0xFF4F46E5)
                                    : const Color(0xFFF87171),
                                width: 3,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${slot.startTime} - ${slot.endTime}',
                                style: const TextStyle(
                                    fontSize: 12, color: Color(0xFF6B7280)),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                slot.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                              if (slot.subtitle != null)
                                Text(
                                  slot.subtitle!,
                                  style: const TextStyle(
                                      fontSize: 12, color: Color(0xFF6B7280)),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

enum SlotType { morning, period, breakTime }

class TimetableSlot {
  const TimetableSlot({
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.title,
    this.subtitle,
  });

  final SlotType type;
  final String startTime;
  final String endTime;
  final String title;
  final String? subtitle;
}

class TimetableDay {
  const TimetableDay({
    required this.name,
    required this.slots,
  });

  final String name;
  final List<TimetableSlot> slots;
}
