import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';

void main() {
  final password = Uri.encodeComponent(r'passwordishere');

  final config = {
    'host': 'localhost',
    'port': '3306',
    'user': 'root',
    'password': password,
    'db': 'DBName',
  };

  final encrypted = encrypt(jsonEncode(config));

  // assets/config klasörünü oluştur
  final dir = Directory('assets/config');
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }

  // Şifrelenmiş config'i dosyaya yaz
  File('assets/config/db_config.enc').writeAsStringSync(encrypted);

  print('Config dosyası oluşturuldu: assets/config/db_config.enc');
}

String encrypt(String data) {
  const key = 'fluttermysql_2024_secure_key';

  // String'i byte'lara çevir
  final bytes = utf8.encode(data);

  // Key'den hash oluştur
  final keyBytes = utf8.encode(key);
  final keyHash = sha256.convert(keyBytes);

  // XOR ile şifrele
  final encrypted = List<int>.filled(bytes.length, 0);
  for (var i = 0; i < bytes.length; i++) {
    encrypted[i] = bytes[i] ^ keyHash.bytes[i % keyHash.bytes.length];
  }

  // Base64'e çevir
  return base64.encode(encrypted);
}
