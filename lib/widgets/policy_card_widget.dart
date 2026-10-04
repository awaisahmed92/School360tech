import 'package:flutter/material.dart';

class PolicyCardWidget extends StatelessWidget {
  const PolicyCardWidget({
    super.key,
    required this.title,
    required this.date,
    required this.onPreview,
  });

  final String title;
  final String date;
  final VoidCallback onPreview;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPreview,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F9FE),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: const Icon(Icons.description_outlined,
                    size: 34, color: Color(0xFF6B7280)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(Icons.article_outlined, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        Text(date,
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF6B7280))),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onPreview,
                    icon: const Icon(Icons.remove_red_eye_outlined, size: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
