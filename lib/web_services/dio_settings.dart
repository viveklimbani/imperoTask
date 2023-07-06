import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/utils/constants.dart';


class DioSettings {
  late Dio dio;
  late Logger logger;
  late SharedPreferences preferences;

  DioSettings(
      {required this.dio, required this.logger, required this.preferences}) {
    initDioSettings();
  }

  initDioSettings() {
    dio.options = BaseOptions(baseUrl: baseUrl);
    dio.interceptors.add(LogInterceptor(
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: false,
        responseBody: false));

    dio.interceptors.add(InterceptorsWrapper(onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
        ) async {
      if (options.method == "GET") {
        logger.d("Request",
            "${options.method} -> ${options.path} -> ${json.encode(options.queryParameters)}");
      } else {
        logger.d("Request",
            "${options.method} -> ${options.path} -> ${options.data.toString()}");
      }

      return handler.next(options); //continue
    }, onResponse: (
        Response response,
        ResponseInterceptorHandler handler,
        ) async {
      logger.d("Response", response.data.toString());
      return handler.next(response); // continue
    }, onError: (
        DioError e,
        ErrorInterceptorHandler handler,
        ) async {
      logger.e("Error", e.response.toString());
      return handler.next(e); //continue
    }));
  }
}

bool isShowingUnauthorizedDialog = false;
