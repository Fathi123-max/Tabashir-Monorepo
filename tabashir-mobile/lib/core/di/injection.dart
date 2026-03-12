import 'package:get_it/get_it.dart';
import 'package:tabashir/core/di/module.config.dart';

// Service locator instance
final GetIt getIt = GetIt.instance;

/// Initializes the dependency injection container
Future<void> initDependencies() async {
  getIt.init();
}
