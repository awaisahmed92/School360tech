import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/admin_state.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text('Admin Dashboard',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _KpiCard(label: 'Total Students', value: '1,248'),
            _KpiCard(label: 'Total Teachers', value: '87'),
            _KpiCard(label: 'Total Parents', value: '2,020'),
            _KpiCard(label: 'Fee Collected', value: 'PKR 4.2M'),
          ],
        ),
        SizedBox(height: 12),
        _Panel(title: 'Attendance Donut / Fee Collection Chart placeholder'),
      ],
    );
  }
}

class AdminStudentsView extends StatelessWidget {
  const AdminStudentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return _CrudPage(
      title: 'Students',
      columns: const ['Name', 'Roll No', 'Class', 'Campus', 'Parent'],
      filters: _studentsFilters(context),
      sampleRows: const [
        ['Muhammad Hamza', '21084', '03-A', 'Autobahn', 'Khaleelullah'],
        ['Hafsa Shaikh', '25156', '01-H', 'Elementary', 'Khaleelullah'],
      ],
    );
  }

  Widget _studentsFilters(BuildContext context) {
    final state = context.watch<AdminState>();
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(labelText: 'Search student'),
            onChanged: context.read<AdminState>().setStudentSearch,
          ),
        ),
        const SizedBox(width: 10),
        DropdownButton<String>(
          value: state.selectedCampus,
          items: const [
            DropdownMenuItem(
                value: 'All Campuses', child: Text('All Campuses')),
            DropdownMenuItem(value: 'Autobahn', child: Text('Autobahn')),
            DropdownMenuItem(value: 'Elementary', child: Text('Elementary')),
          ],
          onChanged: (value) {
            if (value != null) context.read<AdminState>().setCampus(value);
          },
        ),
      ],
    );
  }
}

class AdminParentsView extends StatelessWidget {
  const AdminParentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CrudPage(
      title: 'Parents',
      columns: ['Name', 'CNIC', 'Phone', 'Email', 'Children'],
      sampleRows: [
        [
          'Khaleelullah',
          '4130626524771',
          '+923332949950',
          'rufi@yahoo.com',
          '2'
        ],
      ],
    );
  }
}

class AdminTeachersView extends StatelessWidget {
  const AdminTeachersView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CrudPage(
      title: 'Teachers',
      columns: ['Name', 'Subject', 'Class', 'Phone', 'Email'],
      sampleRows: [
        [
          'Ms. Ayesha',
          'Mathematics',
          '03-A',
          '+923001112223',
          'ayesha@school.com'
        ],
      ],
    );
  }
}

class AdminClassesView extends StatelessWidget {
  const AdminClassesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CrudPage(
      title: 'Classes',
      columns: ['Grade', 'Section', 'Class Teacher', 'Campus', 'Student Count'],
      sampleRows: [
        ['03', 'A', 'Ms. Ayesha', 'Autobahn', '32'],
      ],
    );
  }
}

class AdminTimetableView extends StatelessWidget {
  const AdminTimetableView({super.key});

  @override
  Widget build(BuildContext context) => const _Panel(
        title: 'Admin Timetable',
        subtitle:
            'Class selector + editable timetable slots (period/morning/break).',
      );
}

class AdminAttendanceView extends StatelessWidget {
  const AdminAttendanceView({super.key});

  @override
  Widget build(BuildContext context) => const _Panel(
        title: 'Admin Attendance',
        subtitle: 'Mark present/absent/late and export attendance reports.',
      );
}

class AdminLmsView extends StatelessWidget {
  const AdminLmsView({super.key});

  @override
  Widget build(BuildContext context) => const _Panel(
        title: 'Admin LMS',
        subtitle: 'Manage classes, assignments, resources, and gradebook.',
      );
}

class AdminBillingView extends StatelessWidget {
  const AdminBillingView({super.key});

  @override
  Widget build(BuildContext context) => const _Panel(
        title: 'Admin Billing',
        subtitle: 'Fee heads, invoice generation, paid/unpaid tracking.',
      );
}

class AdminExtracurricularView extends StatelessWidget {
  const AdminExtracurricularView({super.key});

  @override
  Widget build(BuildContext context) => const _Panel(
        title: 'Admin Extracurricular',
        subtitle: 'Programs, courses, terms/FAQ, and enrollment approvals.',
      );
}

class AdminAnnouncementsView extends StatelessWidget {
  const AdminAnnouncementsView({super.key});

  @override
  Widget build(BuildContext context) => const _Panel(
        title: 'Admin Announcements',
        subtitle:
            'Create circulars/news with audience targeting and attachments.',
      );
}

class AdminEventsView extends StatelessWidget {
  const AdminEventsView({super.key});

  @override
  Widget build(BuildContext context) => const _Panel(
        title: 'Admin Events',
        subtitle: 'Calendar-based event creation and publishing.',
      );
}

class AdminPoliciesView extends StatelessWidget {
  const AdminPoliciesView({super.key});

  @override
  Widget build(BuildContext context) => const _Panel(
        title: 'Admin Policies',
        subtitle: 'Policy categories, rich text content, publish/unpublish.',
      );
}

class AdminSettingsView extends StatelessWidget {
  const AdminSettingsView({super.key});

  @override
  Widget build(BuildContext context) => const _Panel(
        title: 'Admin Settings',
        subtitle: 'School profile, campuses, academic year, and app config.',
      );
}

class _CrudPage extends StatelessWidget {
  const _CrudPage({
    required this.title,
    required this.columns,
    required this.sampleRows,
    this.filters,
  });

  final String title;
  final List<String> columns;
  final List<List<String>> sampleRows;
  final Widget? filters;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
            const Spacer(),
            FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Add')),
          ],
        ),
        const SizedBox(height: 12),
        if (filters != null) ...[
          filters!,
          const SizedBox(height: 10),
        ],
        Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [for (final c in columns) DataColumn(label: Text(c))],
              rows: [
                for (final row in sampleRows)
                  DataRow(cells: [for (final col in row) DataCell(Text(col))]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.title, this.subtitle});
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: SizedBox(
        height: 340,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 24)),
                if (subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(subtitle!, textAlign: TextAlign.center),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E8F2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF6B7280))),
          const SizedBox(height: 8),
          Text(value,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
