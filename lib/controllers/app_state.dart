import 'package:flutter/material.dart';

enum ParentTab {
  home('Home', Icons.home_outlined),
  children('My Children', Icons.groups_outlined),
  lms('LMS', Icons.menu_book_outlined),
  timetable('Timetable', Icons.calendar_view_week_outlined),
  billing('Billing', Icons.account_balance_wallet_outlined),
  attendance('Attendance', Icons.fact_check_outlined),
  extracurricular('Extracurricular', Icons.extension_outlined);

  const ParentTab(this.label, this.icon);
  final String label;
  final IconData icon;
}

class AppState extends ChangeNotifier {
  bool _darkMode = false;
  ParentTab _tab = ParentTab.home;
  ParentPage _parentPage = ParentPage.home;
  AdminPage _adminPage = AdminPage.dashboard;

  bool get isDarkMode => _darkMode;
  ParentTab get tab => _tab;
  ParentPage get parentPage => _parentPage;
  AdminPage get adminPage => _adminPage;
  Color get brandColor => const Color(0xFF4F46E5);

  void toggleTheme() {
    _darkMode = !_darkMode;
    notifyListeners();
  }

  void selectTab(ParentTab tab) {
    if (_tab == tab) return;
    _tab = tab;
    _parentPage = switch (tab) {
      ParentTab.home => ParentPage.home,
      ParentTab.children => ParentPage.myChildren,
      ParentTab.lms => ParentPage.lms,
      ParentTab.timetable => ParentPage.timetable,
      ParentTab.billing => ParentPage.billing,
      ParentTab.attendance => ParentPage.attendance,
      ParentTab.extracurricular => ParentPage.extracurricular,
    };
    notifyListeners();
  }

  void openParentPage(ParentPage page) {
    _parentPage = page;
    _tab = switch (page) {
      ParentPage.home => ParentTab.home,
      ParentPage.myChildren ||
      ParentPage.childProfile ||
      ParentPage.editChildProfile =>
        ParentTab.children,
      ParentPage.lms || ParentPage.classDetail => ParentTab.lms,
      ParentPage.timetable => ParentTab.timetable,
      ParentPage.billing => ParentTab.billing,
      ParentPage.attendance => ParentTab.attendance,
      ParentPage.extracurricular ||
      ParentPage.courseDetail =>
        ParentTab.extracurricular,
      ParentPage.parentProfile ||
      ParentPage.editParentProfile ||
      ParentPage.policies ||
      ParentPage.changePassword =>
        _tab,
    };
    notifyListeners();
  }

  void openAdminPage(AdminPage page) {
    _adminPage = page;
    notifyListeners();
  }
}

enum ParentPage {
  home,
  myChildren,
  childProfile,
  editChildProfile,
  lms,
  classDetail,
  timetable,
  billing,
  attendance,
  extracurricular,
  courseDetail,
  parentProfile,
  editParentProfile,
  policies,
  changePassword,
}

enum AdminPage {
  dashboard,
  students,
  parents,
  teachers,
  classes,
  timetable,
  attendance,
  lms,
  billing,
  extracurricular,
  announcements,
  events,
  policies,
  settings,
}
