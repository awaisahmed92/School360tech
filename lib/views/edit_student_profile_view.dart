import 'package:flutter/material.dart';

class EditStudentProfileView extends StatelessWidget {
  const EditStudentProfileView({super.key});

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
              const Text('Edit Student Profile Information',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              const Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _Field(label: 'First Name *'),
                  _Field(label: 'Last Name *'),
                  _Field(label: 'Email Address *'),
                  _Field(label: 'Recovery Email Address *'),
                  _Field(label: 'Phone No *'),
                  _Field(label: 'Recovery Phone No *'),
                ],
              ),
              const SizedBox(height: 12),
              const TextField(
                maxLines: 4,
                decoration: InputDecoration(labelText: 'Address *'),
              ),
              const SizedBox(height: 16),
              Container(
                width: 320,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: const Color(0xFF4F46E5), style: BorderStyle.solid),
                ),
                child: const Center(
                  child: Text(
                      'Drop your image here, or browse\nImage Size 512x512\nSupports: JPG, PNG',
                      textAlign: TextAlign.center),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(onPressed: () {}, child: const Text('Cancel')),
                  const SizedBox(width: 10),
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

class _Field extends StatelessWidget {
  const _Field({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: TextField(decoration: InputDecoration(labelText: label)),
    );
  }
}
