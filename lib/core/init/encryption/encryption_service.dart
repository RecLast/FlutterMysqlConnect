import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';

class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();
  static EncryptionService get instance => _instance;
  EncryptionService._internal();

  static const String _key = 'fluttermysql_2024_secure_key';
  Map<String, String>? _decryptedConfig;

  Future<Map<String, String>> getDatabaseConfig() async {
    if (_decryptedConfig != null) return _decryptedConfig!;

    try {
      // Şifrelenmiş config dosyasını oku
      final String encrypted =
          await rootBundle.loadString('assets/config/db_config.enc');

      // Şifreyi çöz
      final decrypted = _decrypt(encrypted);

      // JSON'a çevir
      _decryptedConfig = Map<String, String>.from(json.decode(decrypted));

      return _decryptedConfig!;
    } catch (e) {
      print('Config okuma hatası: $e');
      rethrow;
    }
  }

  String _decrypt(String encrypted) {
    try {
      // Base64'ten çevir
      final bytes = base64.decode(encrypted);

      // Key'den hash oluştur
      final keyBytes = utf8.encode(_key);
      final keyHash = sha256.convert(keyBytes);

      // XOR ile şifreyi çöz
      final decrypted = List<int>.filled(bytes.length, 0);
      for (var i = 0; i < bytes.length; i++) {
        decrypted[i] = bytes[i] ^ keyHash.bytes[i % keyHash.bytes.length];
      }

      return utf8.decode(decrypted);
    } catch (e) {
      print('Decryption hatası: $e');
      rethrow;
    }
  }

  String encrypt(String data) {
    try {
      // String'i byte'lara çevir
      final bytes = utf8.encode(data);

      // Key'den hash oluştur
      final keyBytes = utf8.encode(_key);
      final keyHash = sha256.convert(keyBytes);

      // XOR ile şifrele
      final encrypted = List<int>.filled(bytes.length, 0);
      for (var i = 0; i < bytes.length; i++) {
        encrypted[i] = bytes[i] ^ keyHash.bytes[i % keyHash.bytes.length];
      }

      // Base64'e çevir
      return base64.encode(encrypted);
    } catch (e) {
      print('Encryption hatası: $e');
      rethrow;
    }
  }
}
