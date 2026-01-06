import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../../core/core.dart';
import '../models/user_model.dart';

class AuthService {
  static final String _userKey = MyConstants.userData;
  static final String _tokenKey = MyConstants.token;
  static final String _roleKey = MyConstants.userRole; // rider or driver

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Save user info and token securely
  Future<void> saveUserData(Map<String, dynamic> user, {String? token}) async {
    final userJson = jsonEncode(user);
    await _storage.write(key: _userKey, value: userJson);
    if (token != null) await _storage.write(key: _tokenKey, value: token);
  }

  /// Save user role (rider or driver)
  Future<void> saveUserRole(String role) async {
    await _storage.write(key: _roleKey, value: role);
  }

  /// Get user role
  Future<String?> getUserRole() async {
    return await _storage.read(key: _roleKey);
  }

  /// Get user data as Map
  Future<UserModel?> getUserData() async {
    final userJson = await _storage.read(key: _userKey);
    if (userJson != null) {
      final map = jsonDecode(userJson);
      return UserModel.fromJson(map);
    }
    return null;
  }

  /// Get auth token
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  /// Logout user (clear secure storage)
  Future<void> logout() async {
    await _storage.deleteAll();
    // await firebaseSignOut();
  }
}
