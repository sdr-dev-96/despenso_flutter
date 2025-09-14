import 'package:flutter/material.dart';
import 'api_service.dart';
import '../utils/storage.dart';

class AuthService extends ChangeNotifier {
  String? token;
  bool get isAuthenticated => token != null;

  Future<bool> login(String email, String password) async {
    final result = await ApiService.login(email, password);
    if (result != null) {
      token = result;
      await Storage.saveToken(token!);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    token = null;
    await Storage.clearToken();
    notifyListeners();
  }

  Future<void> loadToken() async {
    token = await Storage.getToken();
    notifyListeners();
  }
}
