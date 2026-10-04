import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/app_state.dart';
import '../controllers/parent_state.dart';

class MyChildrenView extends StatelessWidget {
  const MyChildrenView({super.key});

  @override
  Widget build(BuildContext context) {
    const children = [
      ('Muhammad Hamza', '21084', '03 | Autobahn Campus Hyderabad'),
      ('Hafsa Shaikh', '25156', '01 | Elementary Section Hyderabad'),
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('My Children',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              itemCount: children.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.25,
              ),
              itemBuilder: (context, index) {
                final child = children[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: const Color(0xFFE9EAFE),
                          child: Text(child.$1.substring(0, 1)),
                        ),
                        const SizedBox(height: 8),
                        Text(child.$1,
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        Text('Roll No. ${child.$2}',
                            style: const TextStyle(color: Color(0xFF6B7280))),
                        Text(child.$3,
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF6B7280))),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              context.read<ParentState>().selectChild(
                                  index == 0 ? 'muhammad' : 'hafsa');
                              context
                                  .read<AppState>()
                                  .openParentPage(ParentPage.childProfile);
                            },
                            child: const Text('View Profile'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
