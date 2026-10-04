import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';

import 'controllers/app_state.dart';
import 'controllers/admin_state.dart';
import 'controllers/parent_state.dart';
import 'core/auth/auth_models.dart';
import 'core/auth/auth_state.dart';
import 'theme/app_theme.dart';
import 'views/admin_views.dart';
import 'views/attendance_view.dart';
import 'views/billing_view.dart';
import 'views/change_password_view.dart';
import 'views/child_profile_view.dart';
import 'views/class_detail_view.dart';
import 'views/course_detail_view.dart';
import 'views/dashboard_view.dart';
import 'views/edit_parent_profile_view.dart';
import 'views/edit_student_profile_view.dart';
import 'views/extracurricular_view.dart';
import 'views/lms_view.dart';
import 'views/login_view.dart';
import 'views/my_children_view.dart';
import 'views/parent_profile_view.dart';
import 'views/policies_view.dart';
import 'views/timetable_view.dart';
import 'widgets/school_nav.dart';
import 'widgets/support_chat_widget.dart';

void main() {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthState()..bootstrap()),
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => ParentState()),
        ChangeNotifierProvider(create: (_) => AdminState()),
      ],
      child: const School360App(),
    ),
  );
}

class School360App extends StatelessWidget {
  const School360App({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    return MaterialApp(
      title: 'School360tech',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeFor(app.brandColor),
      darkTheme: AppTheme.darkThemeFor(app.brandColor),
      themeMode: app.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const _Root(),
    );
  }
}

class _Root extends StatelessWidget {
  const _Root();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthState>();
    if (auth.status == AuthStatus.unknown) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (auth.status == AuthStatus.unauthenticated) {
      return const Stack(
        children: [
          LoginView(),
          Positioned(right: 20, bottom: 20, child: SupportChatButton()),
        ],
      );
    }

    final role = auth.role;
    if (role == UserRole.admin ||
        role == UserRole.teacher ||
        role == UserRole.accountant) {
      return const _AdminShell();
    }
    return const _ParentShell();
  }
}

class _ParentShell extends StatefulWidget {
  const _ParentShell();

  @override
  State<_ParentShell> createState() => _ParentShellState();
}

class _ParentShellState extends State<_ParentShell> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final isCompact = MediaQuery.sizeOf(context).width < 1100;

    return Scaffold(
      key: _scaffoldKey,
      drawer: isCompact
          ? Drawer(
              child: SafeArea(
                child: ListView(
                  children: [
                    for (final item in ParentTab.values)
                      ListTile(
                        leading: Icon(item.icon),
                        title: Text(item.label),
                        onTap: () {
                          context.read<AppState>().selectTab(item);
                          Navigator.of(context).pop();
                        },
                      ),
                  ],
                ),
              ),
            )
          : null,
      body: Stack(
        children: [
          Column(
            children: [
              SchoolNav(
                  onMenu: isCompact
                      ? () => _scaffoldKey.currentState?.openDrawer()
                      : null),
              Expanded(child: _parentBody(app.parentPage)),
            ],
          ),
          const Positioned(right: 20, bottom: 20, child: SupportChatButton()),
        ],
      ),
    );
  }

  Widget _parentBody(ParentPage page) {
    switch (page) {
      case ParentPage.home:
        return const DashboardView();
      case ParentPage.myChildren:
        return const MyChildrenView();
      case ParentPage.childProfile:
        return const ChildProfileView();
      case ParentPage.editChildProfile:
        return const EditStudentProfileView();
      case ParentPage.lms:
        return const LmsView();
      case ParentPage.classDetail:
        return const ClassDetailView();
      case ParentPage.timetable:
        return const TimetableView();
      case ParentPage.billing:
        return const BillingView();
      case ParentPage.attendance:
        return const AttendanceView();
      case ParentPage.extracurricular:
        return const ExtracurricularView();
      case ParentPage.courseDetail:
        return const CourseDetailView();
      case ParentPage.parentProfile:
        return const ParentProfileView();
      case ParentPage.editParentProfile:
        return const EditParentProfileView();
      case ParentPage.policies:
        return const PoliciesView();
      case ParentPage.changePassword:
        return const ChangePasswordView();
    }
  }
}

class _AdminShell extends StatelessWidget {
  const _AdminShell();

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 260,
            color: const Color(0xFF191D33),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Admin Panel',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 18),
                _AdminNavItem(
                    label: 'Dashboard',
                    selected: app.adminPage == AdminPage.dashboard,
                    onTap: () => context
                        .read<AppState>()
                        .openAdminPage(AdminPage.dashboard)),
                _AdminNavItem(
                    label: 'Students',
                    selected: app.adminPage == AdminPage.students,
                    onTap: () => context
                        .read<AppState>()
                        .openAdminPage(AdminPage.students)),
                _AdminNavItem(
                    label: 'Parents',
                    selected: app.adminPage == AdminPage.parents,
                    onTap: () => context
                        .read<AppState>()
                        .openAdminPage(AdminPage.parents)),
                _AdminNavItem(
                    label: 'Teachers',
                    selected: app.adminPage == AdminPage.teachers,
                    onTap: () => context
                        .read<AppState>()
                        .openAdminPage(AdminPage.teachers)),
                _AdminNavItem(
                    label: 'Classes',
                    selected: app.adminPage == AdminPage.classes,
                    onTap: () => context
                        .read<AppState>()
                        .openAdminPage(AdminPage.classes)),
                _AdminNavItem(
                    label: 'Timetable',
                    selected: app.adminPage == AdminPage.timetable,
                    onTap: () => context
                        .read<AppState>()
                        .openAdminPage(AdminPage.timetable)),
                _AdminNavItem(
                    label: 'Attendance',
                    selected: app.adminPage == AdminPage.attendance,
                    onTap: () => context
                        .read<AppState>()
                        .openAdminPage(AdminPage.attendance)),
                _AdminNavItem(
                    label: 'LMS',
                    selected: app.adminPage == AdminPage.lms,
                    onTap: () =>
                        context.read<AppState>().openAdminPage(AdminPage.lms)),
                _AdminNavItem(
                    label: 'Billing',
                    selected: app.adminPage == AdminPage.billing,
                    onTap: () => context
                        .read<AppState>()
                        .openAdminPage(AdminPage.billing)),
                _AdminNavItem(
                    label: 'Extracurricular',
                    selected: app.adminPage == AdminPage.extracurricular,
                    onTap: () => context
                        .read<AppState>()
                        .openAdminPage(AdminPage.extracurricular)),
                _AdminNavItem(
                    label: 'Announcements',
                    selected: app.adminPage == AdminPage.announcements,
                    onTap: () => context
                        .read<AppState>()
                        .openAdminPage(AdminPage.announcements)),
                _AdminNavItem(
                    label: 'Events',
                    selected: app.adminPage == AdminPage.events,
                    onTap: () => context
                        .read<AppState>()
                        .openAdminPage(AdminPage.events)),
                _AdminNavItem(
                    label: 'Policies',
                    selected: app.adminPage == AdminPage.policies,
                    onTap: () => context
                        .read<AppState>()
                        .openAdminPage(AdminPage.policies)),
                _AdminNavItem(
                    label: 'Settings',
                    selected: app.adminPage == AdminPage.settings,
                    onTap: () => context
                        .read<AppState>()
                        .openAdminPage(AdminPage.settings)),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 62,
                  color: const Color(0xFF3F33D0),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text('School360tech Admin',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_none_rounded,
                              color: Colors.white)),
                      TextButton(
                        onPressed: () => context.read<AuthState>().logout(),
                        child: const Text('Logout',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                Expanded(child: _adminBody(app.adminPage)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _adminBody(AdminPage page) {
    switch (page) {
      case AdminPage.dashboard:
        return const AdminDashboardView();
      case AdminPage.students:
        return const AdminStudentsView();
      case AdminPage.parents:
        return const AdminParentsView();
      case AdminPage.teachers:
        return const AdminTeachersView();
      case AdminPage.classes:
        return const AdminClassesView();
      case AdminPage.timetable:
        return const AdminTimetableView();
      case AdminPage.attendance:
        return const AdminAttendanceView();
      case AdminPage.lms:
        return const AdminLmsView();
      case AdminPage.billing:
        return const AdminBillingView();
      case AdminPage.extracurricular:
        return const AdminExtracurricularView();
      case AdminPage.announcements:
        return const AdminAnnouncementsView();
      case AdminPage.events:
        return const AdminEventsView();
      case AdminPage.policies:
        return const AdminPoliciesView();
      case AdminPage.settings:
        return const AdminSettingsView();
    }
  }
}

class _AdminNavItem extends StatelessWidget {
  const _AdminNavItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: selected
            ? Colors.white.withValues(alpha: 0.14)
            : Colors.transparent,
        leading: const Icon(Icons.chevron_right_rounded, color: Colors.white70),
        title: Text(label, style: const TextStyle(color: Colors.white)),
        onTap: onTap,
      ),
    );
  }
}
