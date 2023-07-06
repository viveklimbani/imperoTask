import 'package:flutter/material.dart';
import 'package:impero_task/data/category_list_model.dart';
import 'package:impero_task/data/product_category_list_model.dart';
import 'package:impero_task/repository/product_repository.dart';

import '../di/di_service.dart';

class ProductScreenProvider with ChangeNotifier {
  CategoryListModel _categoryListModel = CategoryListModel.getDefaultModel();
  ProductCategoryListModel _productCategoryListModel =
      ProductCategoryListModel.getDefaultModel();

  CategoryListModel get categoryListModel => _categoryListModel;
  ProductCategoryListModel get productCategoryListModel =>
      _productCategoryListModel;

  ///Lazy load repository
  final ProductRepository _productRepository = getIt.get<ProductRepository>();

  ///Reset data
  resetData() {
    _categoryListModel = CategoryListModel.getDefaultModel();
    _productCategoryListModel = ProductCategoryListModel.getDefaultModel();
  }

  Category? categoryId;
  SubCategories? subCategoryId;
  Product? productData;

  Future<CategoryListModel?> categoryList(Map<String, dynamic> reqBody,
      {force = false}) async {
    try {
      if ((_categoryListModel.status ?? false) && !force)
        return _categoryListModel;
      _categoryListModel = await _productRepository.categoryList(reqBody);
      return _categoryListModel;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<ProductCategoryListModel?> productCategoryList(
      Map<String, dynamic> reqBody,
      {force = false}) async {
    try {
      if ((_productCategoryListModel.status ?? false) && !force)
        return _productCategoryListModel;
      _productCategoryListModel =
          await _productRepository.productCategoryList(reqBody);
      return _productCategoryListModel;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
