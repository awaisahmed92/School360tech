import 'package:flutter/foundation.dart';

class AdminState extends ChangeNotifier {
  String _studentSearch = '';
  String _selectedCampus = 'All Campuses';
  String _selectedGrade = 'All Grades';

  String get studentSearch => _studentSearch;
  String get selectedCampus => _selectedCampus;
  String get selectedGrade => _selectedGrade;

  void setStudentSearch(String value) {
    _studentSearch = value;
    notifyListeners();
  }

  void setCampus(String value) {
    _selectedCampus = value;
    notifyListeners();
  }

  void setGrade(String value) {
    _selectedGrade = value;
    notifyListeners();
  }
}
