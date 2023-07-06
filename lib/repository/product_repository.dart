import 'dart:io';

import 'package:dio/dio.dart';
import 'package:impero_task/data/category_list_model.dart';
import 'package:impero_task/data/product_category_list_model.dart';
import 'package:impero_task/provider/product_screen_provider.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';

import '../common/utils/constants.dart';
import '../common/widget/common_widget.dart';
import 'base_repository.dart';

abstract class ProductRepository {
  Future<CategoryListModel> categoryList(Map<String, dynamic> reqBody);
  Future<ProductCategoryListModel> productCategoryList(
      Map<String, dynamic> reqBody);
}

class ProductRepositoryImp extends BaseRepository implements ProductRepository {
  @override
  Future<CategoryListModel> categoryList(Map<String, dynamic> reqBody) async {
    var responseModel = CategoryListModel.getDefaultModel();
    var header = {'Content-type': 'application/json; charset=utf-8'};

    try {
      if (!await isConnected()) {
        throw const SocketException("No Internet connection");
      }

      final response = await dio.post(API_CATEGORY_LIST,
          data: reqBody, options: Options(headers: header));
      var responseJson = returnResponse(response);

      responseModel = CategoryListModel.fromJson(responseJson);

      return responseModel;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        responseModel.message = "Connectivity Error";
      } else {
        responseModel = CategoryListModel.fromJson(returnResponseError(e));
      }

      return responseModel;
    } on SocketException {
      handleSocketException(categoryList, reqBody,
          provider: Provider.of<ProductScreenProvider>(
              OneContext.instance.context!,
              listen: false));
    } catch (e) {
      logger.d(e);
    }

    return responseModel;
  }

  @override
  Future<ProductCategoryListModel> productCategoryList(
      Map<String, dynamic> reqBody) async {
    var responseModel = ProductCategoryListModel.getDefaultModel();
    var header = {'Content-type': 'application/json; charset=utf-8'};

    try {
      if (!await isConnected()) {
        throw const SocketException("No Internet connection");
      }

      final response = await dio.post(
        API_PRODUCT_LIST,
        data: reqBody,
      );
      var responseJson = returnResponse(response);

      responseModel = ProductCategoryListModel.fromJson(responseJson);

      return responseModel;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        responseModel.message = "Connectivity Error";
      } else {
        responseModel =
            ProductCategoryListModel.fromJson(returnResponseError(e));
      }

      return responseModel;
    } on SocketException {
      handleSocketException(categoryList, reqBody,
          provider: Provider.of<ProductScreenProvider>(
              OneContext.instance.context!,
              listen: false));
    } catch (e) {
      logger.d(e);
    }

    return responseModel;
  }
}
