import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/app_state.dart';
import '../widgets/attendance_calendar.dart';
import '../widgets/invoice_card.dart';
import '../widgets/timetable_grid.dart';

class ChildProfileView extends StatefulWidget {
  const ChildProfileView({super.key});

  @override
  State<ChildProfileView> createState() => _ChildProfileViewState();
}

class _ChildProfileViewState extends State<ChildProfileView>
    with TickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 7, vsync: this);

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _header(context),
          const SizedBox(height: 10),
          TabBar(
            controller: _tabs,
            isScrollable: true,
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Profile'),
              Tab(text: 'Attendance'),
              Tab(text: 'TimeTable'),
              Tab(text: 'Meeting Logs'),
              Tab(text: 'Letters'),
              Tab(text: 'Threads'),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _overviewTab(),
                _profileTab(),
                AttendanceCalendar(
                  monthLabel: 'August 2026',
                  days: List.generate(
                    35,
                    (i) => AttendanceDay(
                      day: i + 1,
                      state: i % 11 == 0
                          ? AttendanceDayState.absent
                          : (i % 13 == 0
                              ? AttendanceDayState.academicHold
                              : AttendanceDayState.present),
                      punchIn: i % 7 == 0 ? null : '09:09 AM',
                      punchOut: i % 7 == 0 ? null : '01:35 PM',
                    ),
                  ),
                ),
                const TimetableGrid(days: _days),
                _meetingLogsTab(),
                _lettersTab(),
                _threadsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            const CircleAvatar(radius: 34, child: Icon(Icons.person, size: 32)),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Muhammad Hamza',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  SizedBox(height: 4),
                  Text(
                      'Roll No. 21084 | Grade 03-A | Autobahn Campus Hyderabad'),
                  SizedBox(height: 6),
                  Wrap(
                    spacing: 10,
                    runSpacing: 4,
                    children: [
                      Text('Security Deposit: PKR 50,000',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      Chip(label: Text('LIAQUAT HOUSE')),
                    ],
                  ),
                ],
              ),
            ),
            OutlinedButton(onPressed: () {}, child: const Text('Report')),
            const SizedBox(width: 8),
            IconButton(
              tooltip: 'Edit student profile',
              onPressed: () => context
                  .read<AppState>()
                  .openParentPage(ParentPage.editChildProfile),
              icon: const Icon(Icons.edit_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Widget _overviewTab() {
    return ListView(
      children: const [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Attendance',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _MiniStat(label: 'Present', value: '23'),
                          _MiniStat(label: 'Absent', value: '2'),
                          _MiniStat(label: 'Rate', value: '92%'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Meeting Logs',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                      SizedBox(height: 10),
                      Text('No Meeting Logs to show'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: InvoiceCard(
                invoiceNo: 'INV-1001',
                months: ['Aug-26', 'Sep-26', 'Oct-26'],
                amount: '12000',
                status: 'Paid',
                items: [
                  ('Tuition Fee', 'Rs.10,000'),
                  ('Extra Facility Charges', 'Rs.2,000')
                ],
                receiveDate: '24 Oct 2026',
                paymentMethod: 'Online',
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Parents Information',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                      SizedBox(height: 8),
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading:
                            CircleAvatar(child: Icon(Icons.person_outline)),
                        title: Text('Khaleelullah'),
                        subtitle: Text('Father'),
                      ),
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading:
                            CircleAvatar(child: Icon(Icons.person_outline)),
                        title: Text('Sadaf Khaleel'),
                        subtitle: Text('Mother'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Siblings Information',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                      SizedBox(height: 8),
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading:
                            CircleAvatar(child: Icon(Icons.person_outline)),
                        title: Text('Hafsa Shaikh'),
                        subtitle: Text('Sister'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Documents Attached',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                      SizedBox(height: 8),
                      Text('No Document to show'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _profileTab() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _infoCard('Personal Information', const [
            ('Email', 'm.hamza@student.school.com'),
            ('Address', 'Qasimabad, Hyderabad'),
            ('Gender', 'Male'),
            ('Date of Birth', '12 Jan 2017'),
            ('Place of Birth', 'Hyderabad'),
          ]),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _infoCard('Medical Information', const [
            ('Blood Group', 'B+'),
            ('Special Needs', '-'),
            ('Academic Support Student', 'No'),
            ('Food Allergies', '-'),
            ('Medical Allergies', '-'),
          ]),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _infoCard('Gmail Credentials', const [
            ('Email Address', 'm.hamza@fps.edu.pk'),
            ('Password', '********'),
          ]),
        ),
      ],
    );
  }

  Widget _meetingLogsTab() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Select Academic Year'))),
                SizedBox(width: 10),
                Expanded(
                    child: TextField(
                        decoration: InputDecoration(labelText: 'Select Tag'))),
                SizedBox(width: 10),
                Expanded(
                    child: TextField(
                        decoration: InputDecoration(labelText: 'Search'))),
              ],
            ),
            SizedBox(height: 12),
            Expanded(child: Center(child: Text('No Meeting Logs to show'))),
          ],
        ),
      ),
    );
  }

  Widget _lettersTab() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Select Academic Year'))),
                SizedBox(width: 10),
                Expanded(
                    child: TextField(
                        decoration: InputDecoration(labelText: 'Search'))),
              ],
            ),
            SizedBox(height: 12),
            Expanded(child: Center(child: Text('No Letters to show'))),
          ],
        ),
      ),
    );
  }

  Widget _threadsTab() {
    return const Row(
      children: [
        SizedBox(
          width: 320,
          child: Card(
            child: Center(child: Text('No threads found for this student.')),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Card(
            child: Center(child: Text('Open a conversation to get started')),
          ),
        ),
      ],
    );
  }

  Widget _infoCard(String title, List<(String, String)> entries) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            for (final item in entries)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.$1,
                        style: const TextStyle(
                            fontSize: 12, color: Color(0xFF6B7280))),
                    Text(item.$2),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
        Text(label, style: const TextStyle(color: Color(0xFF6B7280))),
      ],
    );
  }
}

const List<TimetableDay> _days = [
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
      TimetableSlot(
          type: SlotType.period,
          startTime: '11:15',
          endTime: '12:05',
          title: 'Science',
          subtitle: 'Period 4'),
    ],
  ),
  TimetableDay(
    name: 'Tuesday',
    slots: [
      TimetableSlot(
          type: SlotType.period,
          startTime: '08:10',
          endTime: '09:05',
          title: 'Literary Explorers',
          subtitle: 'Period 1'),
      TimetableSlot(
          type: SlotType.period,
          startTime: '09:05',
          endTime: '10:00',
          title: 'Mathematics',
          subtitle: 'Period 2'),
    ],
  ),
];
