import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:impero_task/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/utils/enum.dart';
import '../common/widget/common_widget.dart';
import '../data/errors.dart';
import '../di/di_service.dart';

class BaseRepository {
  var connectivity = getIt.get<Connectivity>();
  SharedPreferences preferences = getIt.get<SharedPreferences>();
  final dio = getIt.get<Dio>();

  isConnected() async {
    return (await connectivity.checkConnectivity()) != ConnectivityResult.none;
  }

  ///Common API calls

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;

      default:
        BotToast.showText(text: response.statusMessage!);
        var responseJson = json.decode(response.toString());
        return responseJson;
    }
  }

  dynamic returnResponseError(DioError error) {
    switch (error.response?.statusCode) {
      case 400:
        return error.response?.data;
      case 401:
        {
          try {
            Errors errorModel = Errors.fromJson(error.response?.data);
            if (!(errorModel.status ?? true)) {
              showCustomToast(
                  text: errorModel.message, toastType: ToastType.Error);
            }

            return;
          } catch (e) {
            logger.d(e);
          }

          return error.response?.data;
        }

      default:
        var responseJson = error.response?.data;
        return responseJson;
    }
  }

  handleSocketException(Function functionTobeCalled, Map<String, dynamic>? body,
      {ChangeNotifier? provider, shouldAddInList = true}) {
    if (shouldAddInList) {
      ImperoTask.listOfPendingFunctions.add(ConnectivityErrorModel(
          function: functionTobeCalled, reqBody: body, provider: provider!));
    }

    ///can open no internet Screen
    throw const SocketException("no Internet");
  }
}

class ConnectivityErrorModel {
  Function? function;
  Map<String, dynamic>? reqBody;
  ChangeNotifier? provider;

  ConnectivityErrorModel({this.function, this.reqBody, this.provider});

  ConnectivityErrorModel.fromJson(Map<String, dynamic> json) {
    function = json['function'];
    reqBody = json['reqBody'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['function'] = this.function;
    data['reqBody'] = this.reqBody;
    data['provider'] = this.provider;
    return data;
  }
}