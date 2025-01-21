import 'package:bcrypt/bcrypt.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';
import '../init/database/database_service.dart';
import 'auth_service.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  static UserService get instance => _instance;
  UserService._internal();

  final UserRepository _repository = UserRepository();

  bool _verifyPassword(String password, String hashedPassword) {
    return BCrypt.checkpw(password, hashedPassword);
  }

  Future<UserModel?> login(String email, String password) async {
    try {
      final user = await _repository.getUserByEmail(email);

      if (user == null || !_verifyPassword(password, user.password)) {
        throw Exception('E-posta adresi veya şifre hatalı');
      }

      // Son giriş zamanını güncelle
      await _repository.updateLastLogin(user.id);

      // Kullanıcı bilgilerini logla
      print('Giriş yapan kullanıcı ID: ${user.id}');
      print('Giriş yapan kullanıcı: ${user.username}');

      // Oturumu AuthService'e kaydet
      await AuthService.instance.saveSession(user.id);
      AuthService.instance.currentUser = user;
      print('Oturum kaydedildi - UserID: ${user.id}');

      return user;
    } catch (e) {
      print('Error in login: $e');
      rethrow;
    }
  }

  Future<UserModel?> register({
    required String username,
    required String email,
    required String password,
    String? fullName,
  }) async {
    try {
      if (!DatabaseService.instance.isConnected) {
        await DatabaseService.instance.init();
      }

      // Email formatı kontrolü
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        throw Exception('Geçersiz e-posta formatı');
      }

      // Şifre kontrolü
      if (password.length < 6) {
        throw Exception('Şifre en az 6 karakter olmalıdır');
      }

      // Kullanıcı adı kontrolü
      if (username.length < 3) {
        throw Exception('Kullanıcı adı en az 3 karakter olmalıdır');
      }
      if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
        throw Exception(
            'Kullanıcı adı sadece harf, rakam ve alt çizgi içerebilir');
      }

      // Mevcut kullanıcı kontrolü
      final existingEmail = await _repository.getUserByEmail(email);
      if (existingEmail != null) {
        throw Exception('Bu e-posta adresi zaten kullanımda');
      }

      final existingUsername = await _repository.getUserByUsername(username);
      if (existingUsername != null) {
        throw Exception('Bu kullanıcı adı zaten kullanımda');
      }

      // BCrypt ile şifre hashleme
      final salt = BCrypt.gensalt();
      final hashedPassword = BCrypt.hashpw(password, salt);

      final user = await _repository.createUser(
        username: username,
        email: email,
        password: hashedPassword,
        fullName: fullName,
        selectedLanguage: 'tr',
        targetLanguage: 'en',
        proficiencyLevel: 'beginner',
      );

      // Kullanıcı bilgilerini logla
      print('Yeni kayıt olan kullanıcı ID: ${user.id}');
      print('Yeni kayıt olan kullanıcı: ${user.username}');

      // Oturumu kaydet
      await AuthService.instance.saveSession(user.id);
      AuthService.instance.currentUser = user;

      return user;
    } catch (e) {
      if (e.toString().contains('Cannot write to socket')) {
        await DatabaseService.instance.close();
        throw Exception('Veritabanı bağlantısı koptu. Lütfen tekrar deneyin.');
      }
      print('Error in register: $e');
      rethrow;
    }
  }

  Future<void> updatePassword(
      int userId, String oldPassword, String newPassword) async {
    try {
      final user = await _repository.getUserById(userId);
      if (user == null) throw Exception('Kullanıcı bulunamadı');

      // Eski şifre kontrolü
      if (!BCrypt.checkpw(oldPassword, user.password)) {
        throw Exception('Mevcut şifre hatalı');
      }

      // Yeni şifre hashleme
      final salt = BCrypt.gensalt();
      final hashedNewPassword = BCrypt.hashpw(newPassword, salt);

      await _repository.updatePassword(userId, hashedNewPassword);
    } catch (e) {
      print('Error updating password: $e');
      rethrow;
    }
  }

  Future<void> updatePoints(int userId, int points) async {
    try {
      await _repository.updatePoints(userId, points);
    } catch (e) {
      print('Error updating points: $e');
      rethrow;
    }
  }

  Future<void> updateLevel(int userId, int level) async {
    try {
      await _repository.updateLevel(userId, level);
    } catch (e) {
      print('Error updating level: $e');
      rethrow;
    }
  }
}
