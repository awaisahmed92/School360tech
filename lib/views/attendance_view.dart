import 'package:flutter/material.dart';

import '../widgets/attendance_calendar.dart';
import '../widgets/child_selector_row.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  String? selected = 'muhammad';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Attendance',
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
            selectedId: selected,
            onSelected: (id) => setState(() => selected = id),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: AttendanceCalendar(
              monthLabel: 'August 2026',
              days: List.generate(
                35,
                (i) {
                  if (i % 8 == 0) {
                    return AttendanceDay(
                        day: i + 1,
                        state: AttendanceDayState.absent,
                        punchIn: '09:09 AM',
                        punchOut: '-');
                  }
                  if (i % 11 == 0) {
                    return AttendanceDay(
                        day: i + 1, state: AttendanceDayState.academicHold);
                  }
                  return AttendanceDay(
                      day: i + 1,
                      state: AttendanceDayState.present,
                      punchIn: '09:09 AM',
                      punchOut: '01:35 PM');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
