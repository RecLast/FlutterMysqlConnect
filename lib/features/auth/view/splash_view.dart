import 'package:flutter/material.dart';
import '../../../core/init/lang/locale_manager.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/init/database/database_service.dart';
import '../../../core/services/network_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'sign_view.dart';
import '../../home/view/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  String _loadingText = 'Uygulama başlatılıyor...';
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      print('Uygulama başlatılıyor...');

      // Dil ayarları kontrolü
      setState(() => _loadingText = 'Dil ayarları kontrol ediliyor...');
      await LocaleManager.instance.init();
      print('Dil ayarları yüklendi');
      await Future.delayed(const Duration(milliseconds: 500));

      // İnternet bağlantısı kontrolü
      setState(() => _loadingText = 'İnternet bağlantısı kontrol ediliyor...');
      await NetworkService.instance.checkConnection();
      print('İnternet bağlantısı başarılı');
      await Future.delayed(const Duration(milliseconds: 500));

      // Veritabanı bağlantısı kontrolü
      setState(
          () => _loadingText = 'Veritabanı bağlantısı kontrol ediliyor...');
      await DatabaseService.instance.init();
      print('Veritabanı bağlantısı başarılı');
      await Future.delayed(const Duration(milliseconds: 500));

      // Oturum kontrolü
      setState(() => _loadingText = 'Oturum bilgileri kontrol ediliyor...');
      print('Oturum kontrolü başlatılıyor...');

      // AuthService üzerinden tek seferde oturum kontrolü
      final user = await AuthService.instance.checkSession(context);

      if (mounted) {
        if (user != null) {
          print('Ana sayfaya yönlendiriliyor...');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeView()),
          );
        } else {
          print('Giriş sayfasına yönlendiriliyor...');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignView()),
          );
        }
      }
    } catch (e) {
      print('Hata oluştu: $e');
      setState(() {
        _hasError = true;
        _errorMessage = e.toString().replaceAll('Exception: ', '');
        _loadingText = 'Hata Oluştu';
      });
    }
  }

  Future<void> _retryInitialization() async {
    setState(() {
      _hasError = false;
      _errorMessage = null;
      _loadingText = 'Yeniden deneniyor...';
    });
    await _initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.darkBlue['primary']!,
              AppColors.lightBlue['primary']!,
            ],
            stops: const [0.0, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            const FlutterLogo(
              size: 100,
            ),
            const SizedBox(height: 24),
            Text(
              'FlutterMysqlConnect',
              style: AppTextStyles.rowdiesBold.copyWith(
                color: Colors.white,
                fontSize: 36,
                letterSpacing: 1.2,
              ),
            ),
            const Spacer(),
            if (_hasError) ...[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.red.shade200.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.red.shade100,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage ?? 'Bilinmeyen bir hata oluştu',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.ubuntuRegular.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _retryInitialization,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.darkBlue['primary'],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.refresh),
                          const SizedBox(width: 8),
                          Text(
                            'Yeniden Dene',
                            style: AppTextStyles.ubuntuMedium.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
              const SizedBox(height: 16),
              Text(
                _loadingText,
                style: AppTextStyles.ubuntuRegular.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
