import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/app_state.dart';
import '../widgets/faq_accordion_widget.dart';
import '../widgets/toast_notification.dart';

class CourseDetailView extends StatefulWidget {
  const CourseDetailView({super.key});

  @override
  State<CourseDetailView> createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<CourseDetailView> {
  final checks = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () => context
                .read<AppState>()
                .openParentPage(ParentPage.extracurricular),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back to Extracurricular'),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF16A34A),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                CircleAvatar(child: Icon(Icons.psychology_alt_outlined)),
                SizedBox(width: 12),
                Expanded(
                    child: Text('STEM Robotics',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800))),
                Text('Registration',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  const Expanded(
                      child: Text('Course Charges PKR 2,500.00',
                          style: TextStyle(fontWeight: FontWeight.w800))),
                  FilledButton(
                    onPressed: _handleEnroll,
                    child: const Text('Enroll Now'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text('Overview', style: TextStyle(fontWeight: FontWeight.w800)),
          const Text(
              'This practical STEM robotics course introduces core engineering thinking, sensors, and coding logic.'),
          const SizedBox(height: 10),
          CheckboxListTile(
            value: checks[0],
            onChanged: (v) => setState(() => checks[0] = v ?? false),
            title: const Text('I agree to be billed for this course duration.'),
          ),
          CheckboxListTile(
            value: checks[1],
            onChanged: (v) => setState(() => checks[1] = v ?? false),
            title:
                const Text('I understand cancellation limits before deadline.'),
          ),
          CheckboxListTile(
            value: checks[2],
            onChanged: (v) => setState(() => checks[2] = v ?? false),
            title: const Text(
                'I agree my child must continue for full duration after deadline.'),
          ),
          const SizedBox(height: 10),
          const Text('Frequently Asked Questions',
              style: TextStyle(fontWeight: FontWeight.w800)),
          const FaqAccordionWidget(
            items: [
              (
                'What is the Spark Program?',
                'A school extracurricular initiative with practical tracks.'
              ),
              (
                'How soon should I register?',
                'As early as possible due to limited seats.'
              ),
              (
                'How will I be billed?',
                'Through standard monthly invoice workflow.'
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleEnroll() {
    if (!checks.every((x) => x)) {
      ToastNotification.show(
        context,
        message: 'Please agree with all terms and conditions',
        type: ToastType.error,
      );
      return;
    }
    ToastNotification.show(context,
        message: 'Enrollment submitted', type: ToastType.success);
  }
}
