import 'package:flutter/material.dart';

import '../widgets/child_selector_row.dart';
import '../widgets/timetable_grid.dart';

class TimetableView extends StatefulWidget {
  const TimetableView({super.key});

  @override
  State<TimetableView> createState() => _TimetableViewState();
}

class _TimetableViewState extends State<TimetableView> {
  String? selectedId = 'muhammad';

  @override
  Widget build(BuildContext context) {
    const days = [
      TimetableDay(
        name: 'Monday',
        slots: [
          TimetableSlot(
              type: SlotType.morning,
              startTime: '08:00',
              endTime: '08:10',
              title: 'Morning Time'),
          TimetableSlot(
              type: SlotType.period,
              startTime: '08:10',
              endTime: '09:05',
              title: 'Mathematics',
              subtitle: 'Period 1'),
          TimetableSlot(
              type: SlotType.breakTime,
              startTime: '10:55',
              endTime: '11:15',
              title: 'Break'),
        ],
      ),
      TimetableDay(
        name: 'Tuesday',
        slots: [
          TimetableSlot(
              type: SlotType.period,
              startTime: '08:10',
              endTime: '09:05',
              title: 'English Language',
              subtitle: 'Period 1'),
        ],
      ),
      TimetableDay(
        name: 'Wednesday',
        slots: [
          TimetableSlot(
              type: SlotType.period,
              startTime: '08:10',
              endTime: '09:05',
              title: 'Science',
              subtitle: 'Period 1'),
        ],
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Timetable',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          ChildSelectorRow(
            children: const [
              ChildMini(
                  id: 'muhammad',
                  name: 'Muhammad Hamza',
                  meta: '03-A | Autobahn'),
              ChildMini(
                  id: 'hafsa', name: 'Hafsa Shaikh', meta: '01-H | Elementary'),
            ],
            selectedId: selectedId,
            onSelected: (id) => setState(() => selectedId = id),
          ),
          const SizedBox(height: 12),
          const Expanded(child: TimetableGrid(days: days)),
        ],
      ),
    );
  }
}
