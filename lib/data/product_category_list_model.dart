import 'package:impero_task/data/base_model.dart';

class ProductCategoryListModel extends BaseModel {
  bool? status;
  String? message;
  List<Result>? result;

  ProductCategoryListModel({this.status, this.message, this.result});

  ProductCategoryListModel.fromJson(Map<String, dynamic> json) {
    if (json['Status'] == 200 || json['Status'] == 201) {
      status = true;
    } else {
      status = false;
    }
    message = json['Message'];
    if (json['Result'] != null) {
      result = <Result>[];
      json['Result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.result != null) {
      data['Result'] = this.result?.map((v) => v.toJson()).toList();
    }
    return data;
  }
  static ProductCategoryListModel getDefaultModel() => ProductCategoryListModel(
    status: false,
    message: "Something went wrong",
  );
}

class Result {
  String? name;
  String? priceCode;
  String? imageName;
  int? id;

  Result({this.name, this.priceCode, this.imageName, this.id});

  Result.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    priceCode = json['PriceCode'];
    imageName = json['ImageName'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = this.name;
    data['PriceCode'] = this.priceCode;
    data['ImageName'] = this.imageName;
    data['Id'] = this.id;
    return data;
  }
}
