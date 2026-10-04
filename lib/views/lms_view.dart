import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/app_state.dart';
import '../controllers/parent_state.dart';
import '../widgets/child_selector_row.dart';

class LmsView extends StatefulWidget {
  const LmsView({super.key});

  @override
  State<LmsView> createState() => _LmsViewState();
}

class _LmsViewState extends State<LmsView> with TickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 2, vsync: this);
  String selectedChild = 'muhammad';

  @override
  Widget build(BuildContext context) {
    final parent = context.watch<ParentState>();
    const children = [
      ChildMini(
          id: 'muhammad', name: 'Muhammad Hamza', meta: '03-A | Autobahn'),
      ChildMini(id: 'hafsa', name: 'Hafsa Shaikh', meta: '01-H | Elementary'),
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('LMS',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          ChildSelectorRow(
            children: children,
            selectedId: parent.selectedChildId,
            onSelected: (id) {
              setState(() => selectedChild = id);
              context.read<ParentState>().selectChild(id);
            },
          ),
          const SizedBox(height: 10),
          TabBar(
              controller: _tabs,
              tabs: const [Tab(text: 'My Classes'), Tab(text: 'My Gradebook')]),
          const SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: List.generate(
                    6,
                    (i) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.menu_book_outlined),
                            const SizedBox(height: 8),
                            Text('Mathematics 03-A ($i)',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700)),
                            const Text('Spark Program Hyd 2026-27'),
                            const Spacer(),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                  onPressed: () {
                                    context
                                        .read<ParentState>()
                                        .selectClass('class-$i');
                                    context
                                        .read<AppState>()
                                        .openParentPage(ParentPage.classDetail);
                                  },
                                  child: const Text('View Class')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 250,
                      child: Card(
                        child: ListView(
                          children: const [
                            ListTile(title: Text('Mathematics')),
                            ListTile(title: Text('Science')),
                            ListTile(title: Text('Urdu Language')),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Card(
                        child: Center(
                            child: Text('No Gradebook has been generated yet')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
