import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/app_state.dart';

class ClassDetailView extends StatefulWidget {
  const ClassDetailView({super.key});

  @override
  State<ClassDetailView> createState() => _ClassDetailViewState();
}

class _ClassDetailViewState extends State<ClassDetailView>
    with TickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 4, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Class Detail — Mathematics 03-A',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          TextButton.icon(
            onPressed: () =>
                context.read<AppState>().openParentPage(ParentPage.lms),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back to LMS'),
          ),
          const SizedBox(height: 8),
          TabBar(
            controller: _tabs,
            tabs: const [
              Tab(text: 'Stream'),
              Tab(text: 'People'),
              Tab(text: 'Classwork'),
              Tab(text: 'Gradebook'),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _streamTab(),
                _peopleTab(),
                _classworkTab(),
                _gradebookTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _streamTab() {
    return ListView(
      children: const [
        _PostCard(
          teacher: 'Ms. Ayesha',
          timestamp: 'Posted on 3 Oct, 2026 at 09:42 AM',
          body:
              'Please solve worksheet 3 and revise chapter fractions before Thursday.',
        ),
        _PostCard(
          teacher: 'Ms. Ayesha',
          timestamp: 'Posted on 1 Oct, 2026 at 11:15 AM',
          body:
              'Great participation in class today. Homework details uploaded in classwork tab.',
        ),
      ],
    );
  }

  Widget _peopleTab() {
    return Card(
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          Text('1 Teacher', style: TextStyle(fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(child: Icon(Icons.person_outline)),
            title: Text('Ms. Ayesha'),
            subtitle: Text('03 | A | Autobahn'),
          ),
        ],
      ),
    );
  }

  Widget _classworkTab() {
    return Card(
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.assignment_outlined),
            title: Text('Fractions Worksheet #3'),
            subtitle: Text('Due: 10 Oct, 2026'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.assignment_outlined),
            title: Text('Word Problems Revision'),
            subtitle: Text('Due: 12 Oct, 2026'),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  Widget _gradebookTab() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                    child: TextField(
                        decoration: InputDecoration(labelText: 'Term'))),
                SizedBox(width: 10),
                Expanded(
                    child: TextField(
                        decoration:
                            InputDecoration(labelText: 'Show by Test'))),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Student')),
                    DataColumn(label: Text('Overall Score')),
                    DataColumn(label: Text('Tests')),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('Muhammad Hamza')),
                      DataCell(Text('89%')),
                      DataCell(Text('5'))
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Hafsa Shaikh')),
                      DataCell(Text('92%')),
                      DataCell(Text('4'))
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    required this.teacher,
    required this.timestamp,
    required this.body,
  });

  final String teacher;
  final String timestamp;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(child: Icon(Icons.person_outline)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(teacher,
                          style: const TextStyle(fontWeight: FontWeight.w700)),
                      Text(timestamp,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF6B7280))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(body),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.thumb_up_alt_outlined, size: 16),
                SizedBox(width: 4),
                Text('12'),
                SizedBox(width: 14),
                Icon(Icons.favorite_border, size: 16),
                SizedBox(width: 4),
                Text('4'),
                SizedBox(width: 14),
                Icon(Icons.thumb_down_alt_outlined, size: 16),
                SizedBox(width: 4),
                Text('1'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
