import 'package:mysql1/mysql1.dart';
import '../encryption/encryption_service.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static DatabaseService get instance => _instance;
  DatabaseService._internal();

  MySqlConnection? _connection;
  bool _isInitialized = false;
  bool get isConnected => _connection != null && _isInitialized;

  Future<ConnectionSettings> _getSettings() async {
    final config = await EncryptionService.instance.getDatabaseConfig();
    return ConnectionSettings(
      host: config['host']!,
      port: int.parse(config['port']!),
      user: config['user']!,
      password: Uri.decodeComponent(config['password']!),
      db: config['db']!,
      timeout: const Duration(seconds: 30),
    );
  }

  Future<void> init() async {
    if (_isInitialized && _connection != null) {
      try {
        // Bağlantıyı test et
        await _connection!.query('SELECT 1');
        return; // Bağlantı hala aktifse çık
      } catch (e) {
        // Bağlantı kopmuşsa devam et ve yeniden bağlan
        await close();
      }
    }

    try {
      final settings = await _getSettings();
      _connection = await MySqlConnection.connect(settings);
      _isInitialized = true;
      print('Database connection successful');
    } catch (e) {
      _isInitialized = false;
      _connection = null;
      if (e.toString().contains('Connection timed out')) {
        throw Exception(
            'Veritabanına bağlanılamadı. Lütfen bağlantınızı kontrol edin.');
      } else if (e.toString().contains('Access denied')) {
        throw Exception(
            'Veritabanı erişim izni reddedildi. Lütfen bağlantı bilgilerini kontrol edin.');
      } else {
        throw Exception(
            'Veritabanı bağlantısında hata: ${e.toString().split('] ').last}');
      }
    }
  }

  Future<void> close() async {
    await _connection?.close();
    _isInitialized = false;
    _connection = null;
  }

  Future<Results> query(String sql, [List<Object?>? params]) async {
    for (int attempt = 1; attempt <= 3; attempt++) {
      try {
        if (!isConnected) {
          await init();
        }
        return await _connection!.query(sql, params);
      } catch (e) {
        if (e.toString().contains('Cannot write to socket')) {
          await close(); // Bağlantıyı kapat
          if (attempt == 3) {
            throw Exception(
                'Veritabanı bağlantısı sağlanamadı. Lütfen tekrar deneyin.');
          }
          // Kısa bir bekleme süresi ekle
          await Future.delayed(Duration(milliseconds: 500 * attempt));
          continue; // Yeniden dene
        }
        rethrow;
      }
    }
    throw Exception(
        'Veritabanı bağlantısı sağlanamadı. Lütfen tekrar deneyin.');
  }

  Future<Results> executeQuery(String sql, [List<Object?>? params]) async {
    return await query(sql, params);
  }
}
