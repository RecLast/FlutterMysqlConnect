import '../init/database/database_service.dart';
import '../models/user_model.dart';
import 'base_repository.dart';

class UserRepository extends BaseRepository {
  final DatabaseService _db = DatabaseService.instance;

  Future<UserModel?> getUserById(int id) async {
    try {
      final results = await _db.query(
        'SELECT * FROM users WHERE id = ?',
        [id],
      );

      if (results.isEmpty) return null;

      final Map<String, dynamic> userData = {};
      final fields = results.first.fields;

      // Her bir alanı doğru tipte dönüştür
      fields.forEach((key, value) {
        if (value is DateTime) {
          userData[key] = value.toIso8601String();
        } else {
          userData[key] = value;
        }
      });

      return UserModel.fromMap(userData);
    } catch (e) {
      print('Error getting user by id: $e');
      rethrow;
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final results = await _db.query(
        'SELECT * FROM users WHERE email = ?',
        [email],
      );

      if (results.isEmpty) return null;

      final Map<String, dynamic> userData = {};
      final fields = results.first.fields;

      // Her bir alanı doğru tipte dönüştür
      fields.forEach((key, value) {
        if (value is DateTime) {
          userData[key] = value.toIso8601String();
        } else {
          userData[key] = value;
        }
      });

      return UserModel.fromMap(userData);
    } catch (e) {
      print('Error getting user by email: $e');
      rethrow;
    }
  }

  Future<UserModel?> getUserByUsername(String username) async {
    try {
      final results = await _db.query(
        'SELECT * FROM users WHERE username = ?',
        [username],
      );

      if (results.isEmpty) return null;

      final Map<String, dynamic> userData = {};
      final fields = results.first.fields;

      // Her bir alanı doğru tipte dönüştür
      fields.forEach((key, value) {
        if (value is DateTime) {
          userData[key] = value.toIso8601String();
        } else {
          userData[key] = value;
        }
      });

      return UserModel.fromMap(userData);
    } catch (e) {
      print('Error getting user by username: $e');
      rethrow;
    }
  }

  Future<UserModel> createUser({
    required String username,
    required String email,
    required String password,
    String? fullName,
    required String selectedLanguage,
    required String targetLanguage,
    required String proficiencyLevel,
  }) async {
    try {
      final now = DateTime.now().toUtc().toIso8601String();
      final actualFullName = fullName ?? username;

      final results = await _db.query(
        '''INSERT INTO users (
          username, email, password, full_name,
          level, total_points, current_streak, best_streak,
          selected_language, target_language, proficiency_level,
          is_premium, created_at, updated_at, is_active, is_email_verified,
          last_login
        ) VALUES (?, ?, ?, ?, 1, 0, 0, 0, ?, ?, ?, 0, ?, ?, 1, 0, ?)''',
        [
          username,
          email,
          password,
          actualFullName,
          selectedLanguage,
          targetLanguage,
          proficiencyLevel,
          now,
          now,
          now,
        ],
      );

      final userId = results.insertId;
      if (userId == null) throw Exception('Kullanıcı oluşturulamadı');

      final user = await getUserById(userId);
      if (user == null) {
        throw Exception('Kullanıcı oluşturuldu ancak getirilemedi');
      }

      return user;
    } catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }

  Future<UserModel> updateUser(UserModel user) async {
    try {
      await _db.query(
        '''
        UPDATE users SET
          username = ?,
          email = ?,
          full_name = ?,
          profile_image = ?,
          level = ?,
          total_points = ?,
          current_streak = ?,
          best_streak = ?,
          selected_language = ?,
          target_language = ?,
          proficiency_level = ?,
          is_premium = ?,
          is_active = ?,
          is_email_verified = ?
        WHERE id = ?
        ''',
        [
          user.username,
          user.email,
          user.fullName,
          user.profileImage,
          user.level,
          user.totalPoints,
          user.currentStreak,
          user.bestStreak,
          user.selectedLanguage,
          user.targetLanguage,
          user.proficiencyLevel,
          user.isPremium ? 1 : 0,
          user.isActive ? 1 : 0,
          user.isEmailVerified ? 1 : 0,
          user.id,
        ],
      );

      return user;
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  Future<void> updateLastLogin(int userId) async {
    try {
      final now = DateTime.now().toUtc().toIso8601String();
      await _db.query(
        'UPDATE users SET last_login = ? WHERE id = ?',
        [now, userId],
      );
    } catch (e) {
      print('Error updating last login: $e');
      rethrow;
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await _db.query('DELETE FROM users WHERE id = ?', [id]);
    } catch (e) {
      print('Error deleting user: $e');
      rethrow;
    }
  }

  Future<bool> verifyEmail(int userId) async {
    try {
      await _db.query(
        'UPDATE users SET is_email_verified = 1 WHERE id = ?',
        [userId],
      );
      return true;
    } catch (e) {
      print('Error verifying email: $e');
      return false;
    }
  }

  Future<void> updatePassword(int userId, String newPassword) async {
    try {
      final now = DateTime.now().toUtc().toIso8601String();
      await _db.query(
        'UPDATE users SET password = ?, updated_at = ? WHERE id = ?',
        [newPassword, now, userId],
      );
    } catch (e) {
      print('Error updating password: $e');
      rethrow;
    }
  }

  Future<void> updatePoints(int userId, int points) async {
    try {
      final now = DateTime.now().toUtc().toIso8601String();
      await _db.query(
        'UPDATE users SET total_points = total_points + ?, updated_at = ? WHERE id = ?',
        [points, now, userId],
      );
    } catch (e) {
      print('Error updating points: $e');
      rethrow;
    }
  }

  Future<void> updateLevel(int userId, int level) async {
    try {
      final now = DateTime.now().toUtc().toIso8601String();
      await _db.query(
        'UPDATE users SET level = ?, updated_at = ? WHERE id = ?',
        [level, now, userId],
      );
    } catch (e) {
      print('Error updating level: $e');
      rethrow;
    }
  }
}
