import 'package:flutter/material.dart';

class FaqAccordionWidget extends StatelessWidget {
  const FaqAccordionWidget({super.key, required this.items});

  final List<(String, String)> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in items)
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text(item.$1,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            childrenPadding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            children: [
              Align(alignment: Alignment.centerLeft, child: Text(item.$2))
            ],
          ),
      ],
    );
  }
}
