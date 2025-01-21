import 'dart:io';
import 'dart:async';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  static NetworkService get instance => _instance;
  NetworkService._internal();

  Future<void> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      if (result.isEmpty || result[0].rawAddress.isEmpty) {
        throw Exception('İnternet bağlantısı yok');
      }
    } on SocketException catch (_) {
      throw Exception('İnternet bağlantısı yok');
    } on TimeoutException catch (_) {
      throw Exception('İnternet bağlantısı zaman aşımına uğradı');
    } catch (e) {
      throw Exception('İnternet bağlantısı kontrol edilirken hata oluştu: $e');
    }
  }
}
