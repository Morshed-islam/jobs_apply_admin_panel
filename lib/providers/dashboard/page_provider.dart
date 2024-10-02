import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {
  String _selectedPage = 'Dashboard';

  String get selectedPage => _selectedPage;

  void navigateTo(String page) {
    _selectedPage = page;
    notifyListeners(); // Notify the UI to update
  }
}
