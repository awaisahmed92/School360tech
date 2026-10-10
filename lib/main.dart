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

class _ParentShell extends StatelessWidget {
  const _ParentShell();

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();

    return SchoolChrome(
      title: 'School360',
      trailing: const SchoolAccountMenu(),
      items: [
        for (final item in ParentTab.values)
          SchoolNavItem(
            label: item.label,
            icon: item.icon,
            selected: app.tab == item,
            onTap: () => context.read<AppState>().selectTab(item),
          ),
      ],
      body: Stack(
        children: [
          _parentBody(app.parentPage),
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

  SchoolNavItem _item(BuildContext context, String label, IconData icon, AdminPage page, AdminPage current) {
    return SchoolNavItem(
      label: label,
      icon: icon,
      selected: current == page,
      onTap: () => context.read<AppState>().openAdminPage(page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final page = app.adminPage;
    return SchoolChrome(
      title: 'School360',
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: () => context.read<AuthState>().logout(),
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      items: [
        _item(context, 'Dashboard', Icons.dashboard_outlined, AdminPage.dashboard, page),
        _item(context, 'Students', Icons.school_outlined, AdminPage.students, page),
        _item(context, 'Parents', Icons.family_restroom_outlined, AdminPage.parents, page),
        _item(context, 'Teachers', Icons.person_outline, AdminPage.teachers, page),
        _item(context, 'Classes', Icons.class_outlined, AdminPage.classes, page),
        _item(context, 'Timetable', Icons.calendar_view_week_outlined, AdminPage.timetable, page),
        _item(context, 'Attendance', Icons.fact_check_outlined, AdminPage.attendance, page),
        _item(context, 'LMS', Icons.menu_book_outlined, AdminPage.lms, page),
        _item(context, 'Billing', Icons.account_balance_wallet_outlined, AdminPage.billing, page),
        _item(context, 'Extracurricular', Icons.extension_outlined, AdminPage.extracurricular, page),
        _item(context, 'Announcements', Icons.campaign_outlined, AdminPage.announcements, page),
        _item(context, 'Events', Icons.event_outlined, AdminPage.events, page),
        _item(context, 'Policies', Icons.policy_outlined, AdminPage.policies, page),
        _item(context, 'Settings', Icons.settings_outlined, AdminPage.settings, page),
      ],
      body: _adminBody(page),
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

