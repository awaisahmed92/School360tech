import 'package:flutter/material.dart';

class EditParentProfileView extends StatelessWidget {
  const EditParentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Edit Profile Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              const Text('Father Information',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const _TwoCols(),
              const SizedBox(height: 12),
              const Text('Mother Information',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const _TwoCols(),
              const SizedBox(height: 12),
              const Text('Guardian Information',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const _TwoCols(),
              const SizedBox(height: 12),
              const Text('Emergency Contact Information',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const _TwoCols(),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(onPressed: () {}, child: const Text('Cancel')),
                  FilledButton(onPressed: () {}, child: const Text('Save')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TwoCols extends StatelessWidget {
  const _TwoCols();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        SizedBox(
            width: 280,
            child: TextField(decoration: InputDecoration(labelText: 'Name *'))),
        SizedBox(
            width: 280,
            child: TextField(
                decoration: InputDecoration(labelText: 'Email Address *'))),
        SizedBox(
            width: 280,
            child: TextField(
                decoration: InputDecoration(labelText: 'CNIC Number *'))),
        SizedBox(
            width: 280,
            child: TextField(
                decoration: InputDecoration(labelText: 'Occupation'))),
        SizedBox(
            width: 280,
            child: TextField(
                decoration: InputDecoration(labelText: 'Phone No *'))),
        SizedBox(
            width: 280,
            child: TextField(
                decoration: InputDecoration(labelText: 'Designation'))),
      ],
    );
  }
}
