import 'package:injectable/injectable.dart';

@lazySingleton
class LanguageService {
  String _currentLanguage = 'en';

  String get currentLanguage => _currentLanguage;

  void setLanguage(String languageCode) {
    _currentLanguage = languageCode;
  }
}
