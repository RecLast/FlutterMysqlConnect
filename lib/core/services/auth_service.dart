import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  static AuthService get instance => _instance;
  AuthService._internal();

  final UserRepository _userRepository = UserRepository();
  final String _userIdKey = 'user_id';
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  set currentUser(UserModel? user) {
    _currentUser = user;
  }

  Future<void> init() async {
    try {
      print('AuthService: init başlatılıyor...');
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt(_userIdKey);

      if (userId != null) {
        print('AuthService: init - Kayıtlı kullanıcı ID bulundu: $userId');
        _currentUser = await _userRepository.getUserById(userId);
        if (_currentUser != null) {
          print(
              'AuthService: init - Kullanıcı yüklendi: ${_currentUser!.username}');
        }
      } else {
        print('AuthService: init - Kayıtlı kullanıcı bulunamadı');
      }
    } catch (e) {
      print('Error initializing AuthService: $e');
      rethrow;
    }
  }

  // Oturum kontrolü
  Future<UserModel?> checkSession(BuildContext context) async {
    try {
      print('AuthService: Oturum kontrolü başlatılıyor...');

      // Eğer zaten yüklenmiş bir kullanıcı varsa onu kullan
      if (_currentUser != null) {
        print('AuthService: Aktif oturum bulundu');
        return _currentUser;
      }

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt(_userIdKey);

      if (userId == null) {
        print('AuthService: Kayıtlı oturum bulunamadı');
        return null;
      }

      print('AuthService: Kullanıcı ID ($userId) kontrol ediliyor...');
      final user = await _userRepository.getUserById(userId);

      if (user == null) {
        print('AuthService: Kullanıcı bulunamadı - Oturum temizleniyor');
        await clearUser();
        return null;
      }

      print('AuthService: Oturum doğrulama başarılı - ${user.username}');
      _currentUser = user;
      return user;
    } catch (e) {
      print('AuthService: Oturum kontrolünde hata: $e');
      return null;
    }
  }

  // Giriş işlemi
  Future<UserModel?> login(
      BuildContext context, String email, String password) async {
    try {
      final user = await _userRepository.getUserByEmail(email);

      if (user == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('E-posta adresi veya şifre hatalı'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return null;
      }

      // Oturumu kaydet
      await _saveSession(user.id);
      _currentUser = user;

      print('Giriş yapan kullanıcı ID: ${user.id}');
      print('Giriş yapan kullanıcı: ${user.username}');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Giriş başarılı!'),
            backgroundColor: Colors.green,
          ),
        );
      }

      return user;
    } catch (e) {
      print('Error logging in: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Giriş yapılırken hata: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return null;
    }
  }

  // Oturumu kaydet
  Future<void> _saveSession(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, userId);
  }

  // Oturumu temizle
  Future<void> clearUser() async {
    print('AuthService: Oturum temizleniyor...');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    _currentUser = null;
    print('AuthService: Oturum temizlendi');
  }

  Future<void> saveSession(int userId) async {
    print('AuthService: Oturum kaydediliyor - UserID: $userId');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, userId);
    print('AuthService: Oturum kaydedildi');
  }
}
