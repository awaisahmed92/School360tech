import 'package:flutter/material.dart';

enum AttendanceDayState { present, absent, offDay, weekend, academicHold }

class AttendanceCalendar extends StatefulWidget {
  const AttendanceCalendar({
    super.key,
    required this.monthLabel,
    required this.days,
  });

  final String monthLabel;
  final List<AttendanceDay> days;

  @override
  State<AttendanceCalendar> createState() => _AttendanceCalendarState();
}

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  AttendanceDay? _selected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('This Month',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                const Spacer(),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.chevron_left)),
                Text(widget.monthLabel,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.chevron_right)),
              ],
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.days.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 1.15,
              ),
              itemBuilder: (context, index) {
                final item = widget.days[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: item.punchIn == null
                      ? null
                      : () => setState(() => _selected = item),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _colorForState(item.state),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        Center(
                            child: Text('${item.day}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700))),
                        if (item.punchIn != null)
                          const Positioned(
                            top: 4,
                            right: 4,
                            child: Icon(Icons.info_outline, size: 14),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (_selected != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                    'In: ${_selected!.punchIn ?? '-'}   Out: ${_selected!.punchOut ?? '-'}'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _colorForState(AttendanceDayState state) {
    switch (state) {
      case AttendanceDayState.present:
        return const Color(0xFFD1FAE5);
      case AttendanceDayState.absent:
        return const Color(0xFFFEE2E2);
      case AttendanceDayState.offDay:
        return const Color(0xFFFEF3C7);
      case AttendanceDayState.weekend:
        return const Color(0xFFF3F4F6);
      case AttendanceDayState.academicHold:
        return const Color(0xFFEDE9FE);
    }
  }
}

class AttendanceDay {
  const AttendanceDay({
    required this.day,
    required this.state,
    this.punchIn,
    this.punchOut,
  });

  final int day;
  final AttendanceDayState state;
  final String? punchIn;
  final String? punchOut;
}
