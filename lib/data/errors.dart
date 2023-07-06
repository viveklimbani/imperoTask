
import 'base_model.dart';

class Errors extends BaseModel {
  List<String>? pushToken;

  Errors({this.pushToken});

  Errors.fromJson(Map<String, dynamic> json) {
    pushToken = json['push_token'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['push_token'] = pushToken;
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
