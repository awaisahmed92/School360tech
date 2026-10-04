import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/app_state.dart';
import '../controllers/parent_state.dart';
import '../widgets/child_selector_row.dart';
import '../widgets/course_card_widget.dart';

class ExtracurricularView extends StatefulWidget {
  const ExtracurricularView({super.key});

  @override
  State<ExtracurricularView> createState() => _ExtracurricularViewState();
}

class _ExtracurricularViewState extends State<ExtracurricularView> {
  String selected = 'muhammad';

  @override
  Widget build(BuildContext context) {
    final parent = context.watch<ParentState>();
    final hasCourses = parent.selectedChildId == 'muhammad';
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Extracurricular Courses',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          ChildSelectorRow(
            children: const [
              ChildMini(
                  id: 'muhammad',
                  name: 'Muhammad Hamza',
                  meta: '03-A | Autobahn'),
              ChildMini(
                  id: 'hafsa', name: 'Hafsa Shaikh', meta: '01-H | Elementary'),
            ],
            selectedId: parent.selectedChildId,
            onSelected: (id) {
              setState(() => selected = id);
              context.read<ParentState>().selectChild(id);
            },
          ),
          const SizedBox(height: 12),
          if (!hasCourses)
            const Expanded(child: Center(child: Text('No Courses to show')))
          else
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5FDEB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text('FPS SPARK PROGRAM',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 24)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        CourseCardWidget(
                          name: 'Modern Taekwondo',
                          programName: 'Spark Program Hyd 2026-27',
                          instructor: 'Sheryar',
                          charges: 'Rs.1750',
                          duration: '7 months',
                          onTap: () {
                            context
                                .read<ParentState>()
                                .selectCourse('taekwondo');
                            context
                                .read<AppState>()
                                .openParentPage(ParentPage.courseDetail);
                          },
                        ),
                        CourseCardWidget(
                          name: 'Artistic Gymnastics',
                          programName: 'Spark Program Hyd 2026-27',
                          instructor: 'Asra & Maida',
                          charges: 'Rs.2200',
                          duration: '7 months',
                          onTap: () {
                            context
                                .read<ParentState>()
                                .selectCourse('gymnastics');
                            context
                                .read<AppState>()
                                .openParentPage(ParentPage.courseDetail);
                          },
                        ),
                        CourseCardWidget(
                          name: 'STEM Robotics',
                          programName: 'Spark Program Hyd 2026-27',
                          instructor: 'Tech Tree',
                          charges: 'Rs.2500',
                          duration: '7 months',
                          onTap: () {
                            context
                                .read<ParentState>()
                                .selectCourse('stem-robotics');
                            context
                                .read<AppState>()
                                .openParentPage(ParentPage.courseDetail);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
