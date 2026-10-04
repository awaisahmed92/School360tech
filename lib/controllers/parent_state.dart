import 'package:flutter/foundation.dart';

class ParentState extends ChangeNotifier {
  String _selectedChildId = 'muhammad';
  String _selectedClassId = 'math-03a';
  String _selectedCourseId = 'stem-robotics';

  String get selectedChildId => _selectedChildId;
  String get selectedClassId => _selectedClassId;
  String get selectedCourseId => _selectedCourseId;

  void selectChild(String childId) {
    if (_selectedChildId == childId) return;
    _selectedChildId = childId;
    notifyListeners();
  }

  void selectClass(String classId) {
    if (_selectedClassId == classId) return;
    _selectedClassId = classId;
    notifyListeners();
  }

  void selectCourse(String courseId) {
    if (_selectedCourseId == courseId) return;
    _selectedCourseId = courseId;
    notifyListeners();
  }
}
