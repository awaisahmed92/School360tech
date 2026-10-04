import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/app_state.dart';

class ParentProfileView extends StatefulWidget {
  const ParentProfileView({super.key});

  @override
  State<ParentProfileView> createState() => _ParentProfileViewState();
}

class _ParentProfileViewState extends State<ParentProfileView>
    with TickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 4, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _leftSidebar(context),
          const SizedBox(width: 12),
          Expanded(child: _middleContent()),
          const SizedBox(width: 12),
          _billingPanel(context),
        ],
      ),
    );
  }

  Widget _leftSidebar(BuildContext context) {
    return SizedBox(
      width: 270,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      colors: [Color(0xFFE75A7C), Color(0xFF5B4BDE)]),
                ),
              ),
              const SizedBox(height: 10),
              const CircleAvatar(
                  radius: 38, child: Icon(Icons.person, size: 36)),
              const SizedBox(height: 8),
              const Text('Khaleelullah',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
              const SizedBox(height: 4),
              const Chip(label: Text('Father')),
              IconButton(
                tooltip: 'Edit profile',
                onPressed: () => context
                    .read<AppState>()
                    .openParentPage(ParentPage.editParentProfile),
                icon: const Icon(Icons.edit_outlined),
              ),
              const Divider(),
              const _Line(label: 'CNIC', value: '4130626524771'),
              const _Line(label: 'Contact', value: '+923332949950'),
              const _Line(label: 'Email', value: 'rufi@yahoo.com'),
              const SizedBox(height: 8),
              const _Line(label: 'Last Login', value: 'Oct 3, 2026, 7:35 PM'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _middleContent() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TabBar(
              controller: _tabs,
              tabs: const [
                Tab(text: 'Father Info'),
                Tab(text: 'Mother Info'),
                Tab(text: 'Guardian Info'),
                Tab(text: 'Emergency Contact Info'),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabs,
                children: const [
                  _ProfileGrid(entries: [
                    ('FATHER NAME', 'Khaleelullah'),
                    ('FATHER PHONE', '+923332949950'),
                    ('FATHER EMAIL', 'rufi@yahoo.com'),
                    ('CNIC', '4130626524771'),
                    ('ADDRESS', '-'),
                    ('NATIONALITY', 'Pakistan'),
                    ('OCCUPATION', '-'),
                    ('DESIGNATION', '-'),
                  ]),
                  _ProfileGrid(entries: [
                    ('MOTHER NAME', 'Sadaf Khaleel'),
                    ('MOTHER PHONE', '+92337543322'),
                    ('MOTHER EMAIL', 'sadafshaikh2@gmail.com'),
                    ('CNIC', '4320305609952'),
                    ('ADDRESS', '-'),
                    ('NATIONALITY', 'Pakistan'),
                    ('OCCUPATION', '-'),
                    ('DESIGNATION', '-'),
                  ]),
                  _ProfileGrid(entries: [
                    ('NAME', 'Khaleelullah'),
                    ('PHONE', '+923332949950'),
                    ('EMAIL', 'rufishaikh@yahoo.com'),
                    ('RELATION WITH GUARDIAN', 'Father'),
                  ]),
                  _ProfileGrid(entries: [
                    ('EMERGENCY CONTACT NAME', 'Khaleelullah'),
                    ('EMERGENCY CONTACT NUMBER', '+923332949950'),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Children',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                      SizedBox(height: 8),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                child: _ChildCard(
                                    name: 'Muhammad Hamza',
                                    rollNo: '21084',
                                    classCampus: '03 | Autobahn Campus')),
                            SizedBox(width: 8),
                            Expanded(
                                child: _ChildCard(
                                    name: 'Hafsa Shaikh',
                                    rollNo: '25156',
                                    classCampus: '01 | Elementary Section')),
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
      ),
    );
  }

  Widget _billingPanel(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Billing',
                      style: TextStyle(fontWeight: FontWeight.w800)),
                  const Spacer(),
                  TextButton(
                    onPressed: () => context
                        .read<AppState>()
                        .openParentPage(ParentPage.billing),
                    child: const Text('Go to Billing'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('No billing data to show'),
            ],
          ),
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
              child: Text(label,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF6B7280)))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _ProfileGrid extends StatelessWidget {
  const _ProfileGrid({required this.entries});
  final List<(String, String)> entries;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3.2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 8,
      children: [
        for (final entry in entries)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.$1,
                  style:
                      const TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
              Text(entry.$2),
            ],
          ),
      ],
    );
  }
}

class _ChildCard extends StatelessWidget {
  const _ChildCard({
    required this.name,
    required this.rollNo,
    required this.classCampus,
  });

  final String name;
  final String rollNo;
  final String classCampus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE6E8F2)),
      ),
      child: Column(
        children: [
          CircleAvatar(radius: 24, child: Text(name.substring(0, 1))),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
          Text('Roll No. $rollNo'),
          Text(classCampus,
              style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => context
                  .read<AppState>()
                  .openParentPage(ParentPage.childProfile),
              child: const Text('View Profile'),
            ),
          ),
        ],
      ),
    );
  }
}
