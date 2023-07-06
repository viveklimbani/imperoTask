import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:impero_task/provider/product_screen_provider.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_route.gr.dart';
import '../repository/base_repository.dart';
import '../repository/product_repository.dart';
import '../session/session.dart';
import '../web_services/dio_settings.dart';

GetIt getIt = GetIt.instance;

Future<void> getServices() async {
  /// Async packages
  var preferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(preferences);
  getIt.registerSingleton<Session>(Session());

  ///Sync packages
  getIt.registerFactory(() => Connectivity());
  var dio = Dio();
  var logger = Logger();
  getIt.registerSingleton(dio);
  getIt.registerSingleton(logger);
  getIt.registerSingleton<AppRouter>(AppRouter());

  /// Repositories
  getIt.registerFactory<BaseRepository>(() => BaseRepository());
  getIt.registerFactory<ProductRepository>(() => ProductRepositoryImp());
  getIt.registerSingleton<ProductScreenProvider>(ProductScreenProvider());

  /// Init custom DIO settings for network calls
  DioSettings(dio: dio, logger: logger, preferences: preferences);
}
