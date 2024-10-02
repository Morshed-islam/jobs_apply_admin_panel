import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? errorMessage;

  AuthProvider() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners(); // Notify all listeners when the auth state changes
    });
  }

  User? get user => _user;
  bool get isLoggedIn => _user != null;
  String? get error => errorMessage;

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      errorMessage = null;
      await _saveLoginData(email); // Save user data to SharedPreferences
      notifyListeners();
    } catch (e) {
      errorMessage = 'Login failed. Please check your credentials.';
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _clearLoginData(); // Clear user data from SharedPreferences
    notifyListeners();
  }

  Future<void> _saveLoginData(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  Future<void> _clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('email')) {
      // Perform login with saved email (if needed)
      // Optionally, you can check if the user is already logged in
    }
  }
}
