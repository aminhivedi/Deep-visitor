import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _username;
  String? _nationalCode;

  bool get isAuthenticated => _isAuthenticated;
  String? get username => _username;
  String? get nationalCode => _nationalCode;

  Future<bool> login(String username, String password) async {
    // در حالت واقعی اینجا به سرور متصل می‌شویم
    if (username == 'admin' && password == 'admin123') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username);
      
      _isAuthenticated = true;
      _username = username;
      _nationalCode = '1234567890'; // کد ملی نمونه
      
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    
    if (isLoggedIn) {
      _isAuthenticated = true;
      _username = prefs.getString('username');
      notifyListeners();
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    _isAuthenticated = false;
    _username = null;
    notifyListeners();
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    // در حالت واقعی اعتبارسنجی می‌شود
    return true;
  }
}
