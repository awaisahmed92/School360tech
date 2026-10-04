import 'package:flutter/material.dart';

class FeedWidget extends StatelessWidget {
  const FeedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your Feed',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            for (final msg in const [
              'FPS Hyderabad shared a new post about STEM robotics class.',
              'Grade 03-A homework posted by Ms. Ayesha.',
            ])
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(msg),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.thumb_up_alt_outlined, size: 14),
                        SizedBox(width: 4),
                        Text('12'),
                        SizedBox(width: 12),
                        Icon(Icons.favorite_border, size: 14),
                        SizedBox(width: 4),
                        Text('6'),
                      ],
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
