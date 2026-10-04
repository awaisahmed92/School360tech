import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/app_state.dart';
import '../widgets/attendance_donut_widget.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/feed_widget.dart';
import '../widgets/news_circulars_widget.dart';
import '../widgets/timetable_widget.dart';
import '../widgets/upcoming_events_widget.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 920) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              _GreetingBanner(),
              SizedBox(height: 12),
              NewsCircularsWidget(),
              SizedBox(height: 12),
              FeedWidget(),
              SizedBox(height: 12),
              AttendanceDonutWidget(),
              SizedBox(height: 12),
              CalendarWidget(),
              SizedBox(height: 12),
              UpcomingEventsWidget(),
              SizedBox(height: 12),
              TimetableWidget(),
            ],
          );
        }

        return const SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _GreetingBanner(),
              SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        NewsCircularsWidget(),
                        SizedBox(height: 12),
                        FeedWidget(),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        CalendarWidget(),
                        SizedBox(height: 12),
                        UpcomingEventsWidget(),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        AttendanceDonutWidget(),
                        SizedBox(height: 12),
                        TimetableWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GreetingBanner extends StatelessWidget {
  const _GreetingBanner();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hey, Khaleelullah',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Welcome back! Here is your child progress and school updates.',
                    style: TextStyle(color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),
            FilledButton.icon(
              onPressed: () => context
                  .read<AppState>()
                  .openParentPage(ParentPage.myChildren),
              icon: const Icon(Icons.shop_2_outlined),
              label: const Text('Open My Children'),
            ),
          ],
        ),
      ),
    );
  }
}
