import 'package:flutter/material.dart';

import '../widgets/policy_card_widget.dart';
import '../widgets/policy_preview_modal.dart';

class PoliciesView extends StatelessWidget {
  const PoliciesView({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Late Payment Policy', '24 Oct. 2023'),
      ('Due Date Extension Policy', '24 Oct. 2023'),
      ('Academic Hold Policy', '24 Oct. 2023'),
      ('Fee Checkpoints', '24 Oct. 2023'),
      ('Adv. Income Tax Policy', '24 Oct. 2023'),
      ('Bill Payment Options', '24 Oct. 2023'),
      ('Withdrawal Policy', '24 Oct. 2023'),
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Our Policies',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text('Billing',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.25,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return PolicyCardWidget(
                  title: item.$1,
                  date: item.$2,
                  onPreview: () => showPolicyPreviewModal(
                    context,
                    title: item.$1,
                    content:
                        'Policy details for ${item.$1}.\n\n1) This is a policy paragraph.\n2) Another important note.',
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
